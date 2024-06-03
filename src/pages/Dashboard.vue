<template>
    <div class="ma-5">
        <v-row>
            <v-col>
                <v-card>
                    <v-card-title class="text-overline">
                        Cedulas

                        <div class="text-green-darken-3 text-h3 font-weight-bold">{{ count }}</div>

                        <div class="text-h6 text-medium-emphasis font-weight-regular">
                            ₱ {{ total }} Total Amount
                        </div>
                    </v-card-title>
                    <br>
                    <v-card-text>
                        <div class="position-absolute mt-n8 text-caption text-green-darken-3">
                            Total Amount of Cedulas
                        </div>
                        <v-progress-linear color="green-darken-3" height="22" :model-value="reviewCed" rounded="lg"></v-progress-linear>

                        <div class="d-flex justify-space-between py-3">
                            <span class="text-green-darken-3 font-weight-medium">
                                ₱ {{ total }} Total Amount
                            </span>

                            <span class="text-medium-emphasis"> ₱ {{ expect }} Expected in 1 year </span>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
        <v-row>
            <v-col>
                <h1>Expired Cedulas</h1>
                <v-table fixed-header height="40vh">
                    <thead>
                        <tr>
                            <th class="text-left">CTC Number</th>
                            <th class="text-left">Name</th>
                            <th class="text-left">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in filteredDocuments" :key="item.cedula_number" class="row">
                            <td>{{ item.cedula_number }}</td>
                            <td>{{ fullName(item) }}</td>
                            <td>
                                <Form titleBox="View" icon="mdi-file-eye-outline" :selectedRow="item" />
                            </td>
                        </tr>
                    </tbody>
                </v-table>
            </v-col>
        </v-row>
    </div>
</template>
<script>
import axios from 'axios';

export default {
    data() {
        return {
            review: '',
            count: '',
            total: '',
            expect: '2000',
            cedulas: [],
        }
    },
    methods: {
        countCed() {
            axios.post('http://www.localhost/cedula/src/php/functions.php', {
                action: 'count',
            }).then(response => {
                this.count = response.data;
            })
        },
        totalCed() {
            axios.post('http://www.localhost/cedula/src/php/functions.php', {
                action: 'total',
            }).then(response => {
                this.total = parseInt(response.data);
            })
        },
        fetchData() {
            axios.get('http://www.localhost/cedula/src/php/fetch.php')
                .then(response => {
                    this.cedulas = response.data;
                }).catch(error => {
                    console.error(error);
                });
        },
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
    },
    computed: {
        reviewCed() {
            return this.review = (this.total / this.expect) * 100;
        },
        filteredDocuments() {
            let filteredDocs = this.cedulas;
            const currentDate = new Date();

            filteredDocs = filteredDocs.filter(cedula => {
                const issuedDate = new Date(cedula.date_issued);
                issuedDate.setFullYear(issuedDate.getFullYear() + 1);
                return issuedDate < currentDate;
            });

            return filteredDocs;
        }
    },
    mounted() {
        this.countCed();
        this.totalCed();
        this.fetchData();
    }
}
</script>