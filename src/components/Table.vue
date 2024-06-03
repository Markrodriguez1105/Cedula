<template>
    <v-table fixed-header height="80vh">
        <thead>
            <tr>
                <th class="text-left">CTC Number</th>
                <th class="text-left">Name</th>
                <th class="text-left">Total Amount</th>
                <th class="text-left">Status</th>
                <th class="text-left">Action</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="item in filteredDocuments" :key="item.cedula_number" class="row">
                <td>{{ item.cedula_number }}</td>
                <td>{{ fullName(item) }}</td>
                <td>{{ totalAmount(item) }}</td>
                <td>{{ status(item.date_issued) }}</td>
                <td>
                    <Form titleBox="View" icon="mdi-file-eye-outline" :selectedRow="item" />
                </td>
            </tr>
        </tbody>
    </v-table>
</template>
<script>
import axios from 'axios';
import Form from './Form.vue';

export default {
    props: {
        search: {
            type: String,
        }
    },
    data() {
        return {
            cedulas: [],
        }
    },
    methods: {
        fullName(item) {
            const { lname, fname, mname } = item;
            const middleInitial = mname ? `${mname.charAt(0)}.` : '';
            return `${lname}, ${fname} ${middleInitial}`.trim();
        },
        status(date) {
            const currentDate = new Date();
            const issuedDate = new Date(date)
            issuedDate.setFullYear(issuedDate.getFullYear() + 1);

            if (issuedDate < currentDate) {
                return 'Expired';
            } else {
                return 'Valid';
            }
        },
        fetchData() {
            axios.get('http://www.localhost/cedula/src/php/fetch.php')
                .then(response => {
                    this.cedulas = response.data;
                }).catch(error => {
                    console.error(error);
                });
        },
        totalAmount(cedulas) {
            const grossAmounts = parseInt(cedulas.gross_receipts);
            const incomeAmounts = parseInt(cedulas.income_property);
            const salariesAmounts = parseInt(cedulas.salaries_receipts);
            const basicCommTax = parseInt(cedulas.basic_comm_tax);
            const interest = parseInt(cedulas.interest);

            const safeGrossAmounts = Number.isNaN(grossAmounts) ? 0 : grossAmounts;
            const safeIncomeAmounts = Number.isNaN(incomeAmounts) ? 0 : incomeAmounts;
            const safeSalariesAmounts = Number.isNaN(salariesAmounts) ? 0 : salariesAmounts;
            const safeBasicCommTax = Number.isNaN(basicCommTax) ? 0 : basicCommTax;
            const safeInterest = Number.isNaN(interest) ? 0 : interest;

            const total = safeGrossAmounts + safeIncomeAmounts + safeSalariesAmounts + safeBasicCommTax + safeInterest;
            return total;
        },
    },
    computed: {
        filteredDocuments() {
            let filteredDocs = this.cedulas

            if (this.search) {
                filteredDocs = filteredDocs.filter(cedula =>
                    cedula.fname.toLowerCase().includes(this.search.toLowerCase()) ||
                    cedula.mname.toLowerCase().includes(this.search.toLowerCase()) ||
                    cedula.lname.toLowerCase().includes(this.search.toLowerCase())
                );
            }

            return filteredDocs;
        },
    },
    mounted() {
        this.fetchData();
    }
}
</script>
<style scoped>
.row {
    cursor: pointer;
}

.row:hover {
    box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.2);
}
</style>