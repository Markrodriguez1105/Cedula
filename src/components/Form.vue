<template>
    <v-dialog persistent width="80vw" transition="dialog-bottom-transition">
        <template v-slot:activator="{ props: activatorProps }">
            <v-btn width="100%" :prepend-icon="icon" variant="flat" v-bind="activatorProps" color="surface-variant"
                :text="titleBox"></v-btn>
        </template>

        <template v-slot:default="{ isActive }">
            <v-toolbar color="primary" class="px-10"><v-icon>{{ icon }}</v-icon>
                <v-toolbar-title>COMMUNITY TAX CERTIFICATE - INDIVIDUAL</v-toolbar-title>
                <v-spacer></v-spacer>
                <v-btn icon @click="isActive.value = false"><v-icon>mdi-close</v-icon></v-btn>
            </v-toolbar>
            <v-card class="pa-5">
                <v-form @submit.prevent class=" d-flex flex-column ga-2">
                    <v-row>
                        <v-col cols="3">
                            <v-text-field label="CTC Number" v-model="cedulas.cedula_number" readonly></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field label="Firstname" v-model="cedulas.fname" :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field label="Middlename" v-model="cedulas.mname" :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field label="Lastname" v-model="cedulas.lname" :readonly="onEdit"></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col>
                            <v-text-field label="Height (cm)" v-model="cedulas.height" type="number"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field label="Weight (kg)" v-model="cedulas.weight" type="number"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col cols="9">
                            <v-text-field label="Address" v-model="cedulas.address" :readonly="onEdit"></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col>
                            <v-select label="Gender" :items="['Male', 'Female']" v-model="cedulas.gender"
                                :readonly="onEdit"></v-select>
                        </v-col>
                        <v-col>
                            <v-select label="Citizenship" :items="['Filipino', 'Other']" v-model="cedulas.citizenship"
                                :readonly="onEdit"></v-select>
                        </v-col>
                        <v-col>
                            <v-select label="Civil Status" :items="['Single', 'Married', 'Widowed']"
                                v-model="cedulas.civil_status" :readonly="onEdit"></v-select>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="3">
                            <v-text-field v-model="cedulas.birthdate" label="Birthdate" type="date"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field label="Place of Birth" v-model="cedulas.place_of_birth"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col>
                            <v-text-field label="Occupation" v-model="cedulas.occupation"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field label="TIN No." v-model="cedulas.tin_number"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="3">
                            <v-text-field v-model="cedulas.date_issued" label="Date Issued" type="date"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field label="Place of Issue" v-model="cedulas.place_of_issue"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                    </v-row>
                    <!-- Community Tax Fields -->
                    <v-divider></v-divider>
                    <v-row>
                        <v-col>
                            <h3>Basic Community Tax</h3>
                            <v-radio-group v-model="cedulas.basic_comm_tax" row :readonly="onEdit">
                                <v-radio label="₱5.00" value="5"></v-radio>
                                <v-radio label="Voluntary or Exempted (₱1.00)" value="1"></v-radio>
                            </v-radio-group>
                        </v-col>
                    </v-row>
                    <h3>Additional Community Tax</h3>
                    <v-row>
                        <v-col cols="5">
                            <p>Gross receipts or earning derived from business during the preceding year (₱1.00 for
                                every ₱1,000.00)</p>
                        </v-col>
                        <v-col>
                            <v-text-field label="Gross Receipts or Earnings" v-model="cedulas.gross_amounts"
                                type="number" prefix="₱" :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col cols="3">
                            <v-text-field prefix="₱" label="Amount" v-model="computedBusiness" type="number"
                                readonly></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="5">
                            <p>Salaries or gross receipt or earning derived from exercise of profession or pursuit of
                                any occupation (₱1.00 for every ₱1,000.00)</p>
                        </v-col>
                        <v-col>
                            <v-text-field prefix="₱" label="Salaries or Gross Receipts from Exercise of Profession"
                                v-model="cedulas.salaries_amounts" type="number" :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col cols="3">
                            <v-text-field prefix="₱" label="Amount" v-model="computeSalary" type="number"
                                readonly></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row>
                        <v-col cols="5">
                            <p>Income from real property (₱1.00 for every ₱1,000.00)</p>
                        </v-col>
                        <v-col>
                            <v-text-field prefix="₱" label="Income from Real Property" v-model="cedulas.income_amounts"
                                type="number" :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col cols="3">
                            <v-text-field prefix="₱" label="Amount" v-model="computedState" type="number"
                                readonly></v-text-field>
                        </v-col>
                    </v-row>
                    <!-- Tax Calculation Fields -->
                    <v-divider></v-divider>
                    <v-row>
                        <v-col>
                            <v-text-field prefix="₱" label="ADT Total" v-model="totalAddComm" type="number"
                                readonly></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field prefix="₱" label="Interest" v-model="cedulas.interest" type="number"
                                :readonly="onEdit"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field prefix="₱" label="Total Amount Paid" v-model="totalAmount" type="number"
                                readonly></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row class="justify-end">
                        <v-col cols="auto">
                            <v-btn flat size="large" text="Cancel" @click="cancel(isActive)"
                                prepend-icon="mdi-close"></v-btn>
                            <v-dialog v-model="discardOverlay" persistent max-width="500px"
                                transition="dialog-transition">
                                <v-card>
                                    <v-alert title="System Warning"
                                        text="Are you sure you want to cancel this transaction? Any data you have entered will not be saved and will be lost."
                                        type="warning" variant="outlined">
                                        <v-card-actions class="pa-0">
                                            <v-spacer></v-spacer>
                                            <v-btn variant="tonal" text="Cancel"
                                                @click="discardOverlay = false"></v-btn>
                                            <v-btn text="Discard"
                                                @click="load(), isActive.value = false, discardOverlay = false"></v-btn>
                                        </v-card-actions>
                                    </v-alert>
                                </v-card>
                            </v-dialog>
                        </v-col>
                        <v-col cols="auto">
                            <v-btn v-if="!onEdit" color="primary" size="large" text="Submit" type="submit"
                                prepend-icon="mdi-content-save-check" variant="flat" @click="submit()"></v-btn>
                            <v-dialog v-model="success" persistent max-width="500px" transition="dialog-transition">
                                <v-card>
                                    <v-alert title="System Message" text="Information has been submit successfully"
                                        type="success" variant="outlined">
                                        <v-card-actions class="pa-0">
                                            <v-spacer></v-spacer>
                                            <v-btn variant="tonal" text="Okay"
                                                @click="success = false, isActive.value = false"></v-btn>
                                        </v-card-actions>
                                    </v-alert>
                                </v-card>
                            </v-dialog>
                        </v-col>
                    </v-row>
                </v-form>
            </v-card>
        </template>
    </v-dialog>
</template>
<script>
import axios from 'axios';

export default {
    props: {
        fetchData: {
            type: Function,
        },
        selectedRow: {
            type: Object,
        },
        titleBox: {
            type: String,
            required: true
        },
        icon: {
            type: String,
            require: true,
        }
    },
    data() {
        return {
            success: false,
            onEdit: false,
            discardOverlay: false,
            cedulas: {
                cedula_number: '',
                fname: '',
                mname: '',
                lname: '',
                gender: '',
                address: '',
                birthdate: '',
                place_of_birth: '',
                citizenship: '',
                civil_status: '',
                height: '',
                weight: '',
                occupation: '',
                tin_number: '',
                date_issued: new Date().toISOString().substring(0, 10),
                place_of_issue: 'Barangay Palestina, Pili, Camarines Sur',
                basic_comm_tax: '',
                gross_receipts: '',
                gross_amounts: '',
                salaries_receipts: '',
                salaries_amounts: '',
                income_property: '',
                income_amounts: '',
                total: '',
                interest: '',
                total_amount_paid: '',
            },
        }
    },
    methods: {
        submit() {
            axios.post('http://www.localhost/cedula/src/php/insert.php', {
                cedula_number: this.cedulas.cedula_number,
                fname: this.cedulas.fname,
                mname: this.cedulas.mname,
                lname: this.cedulas.lname,
                gender: this.cedulas.gender,
                address: this.cedulas.address,
                birthdate: this.cedulas.birthdate,
                place_of_birth: this.cedulas.place_of_birth,
                citizenship: this.cedulas.citizenship,
                civil_status: this.cedulas.civil_status,
                height: this.cedulas.height,
                weight: this.cedulas.weight,
                occupation: this.cedulas.occupation,
                tin_number: this.cedulas.tin_number,
                date_issued: this.cedulas.date_issued,
                place_of_issue: this.cedulas.place_of_issue,
                basic_comm_tax: this.cedulas.basic_comm_tax,
                gross_receipts: this.cedulas.gross_receipts,
                gross_amounts: this.cedulas.gross_amounts,
                salaries_receipts: this.cedulas.salaries_receipts,
                salaries_amounts: this.cedulas.salaries_amounts,
                income_property: this.cedulas.income_property,
                income_amounts: this.cedulas.income_amounts,
                interest: this.cedulas.interest,

            }).then((response) => {
                this.fetchData();
                this.success = true;
            })
        },
        fullName(item) {
            const { lname, fname, mname, suffix } = item;
            const middleInitial = mname ? `${mname.charAt(0)}.` : '';
            return `${lname}, ${fname} ${middleInitial} ${suffix}`.trim();
        },
        cancel(isActive) {
            if (Object.values(this.cedulas).some(value => value) && !this.selectedRow) {
                this.discardOverlay = true;
            } else {
                isActive.value = false;
            }
        },
        load() {
            if (this.selectedRow) {
                this.cedulas = this.selectedRow;
                this.onEdit = true;
            } else {
                axios.post('http://www.localhost/cedula/src/php/functions.php', {
                    action: 'getLastId',
                }).then(response => {
                    this.cedulas.cedula_number = this.generateId(response.data);
                }),
                    this.cedulas.mname = '',
                    this.cedulas.lname = '',
                    this.cedulas.fname = '',
                    this.cedulas.gender = '',
                    this.cedulas.address = '',
                    this.cedulas.birthdate = '',
                    this.cedulas.place_of_birth = '',
                    this.cedulas.citizenship = '',
                    this.cedulas.civil_status = '',
                    this.cedulas.height = '',
                    this.cedulas.weight = '',
                    this.cedulas.occupation = '',
                    this.cedulas.tin_number = '',
                    this.cedulas.date_issued = new Date().toISOString().substring(0, 10),
                    this.cedulas.place_of_issue = 'Barangay Palestina, Pili, Camarines Sur',
                    this.cedulas.basic_comm_tax = '',
                    this.cedulas.gross_receipts = '',
                    this.cedulas.gross_amounts = '',
                    this.cedulas.salaries_receipts = '',
                    this.cedulas.salaries_amounts = '',
                    this.cedulas.income_property = '',
                    this.cedulas.income_amounts = ''
                this.cedulas.interest = ''
            }
        },
        generateId(id) {
            if (id) {
                const year = new Date().getFullYear();
                let genid = 'CC' + year + '-';
                for (let index = 0; index < 5 - id.length; index++) {
                    genid = genid + '0';
                }
                genid = genid + (parseInt(id) + 1);
                return genid;
            } else {
                const year = new Date().getFullYear();
                let genid = 'CC' + year + '-';
                for (let index = 0; index < 4; index++) {
                    genid = genid + '0';
                }
                genid = genid + 1;
                return genid;
            }
        }
    },
    computed: {
        computeSalary() {
            if (this.cedulas.salaries_amounts < 0) {
                return 0;
            }
            const tax = this.cedulas.salaries_amounts / 1000 | 0;
            if (tax < 5000 && tax > -1) {
                return this.cedulas.salaries_receipts = tax;
            }
            return 5000;
        },
        computedBusiness() {
            if (this.cedulas.gross_amounts < 0) {
                return 0;
            }
            const tax = this.cedulas.gross_amounts / 1000 | 0;
            if (tax < 5000 && tax > -1) {
                return this.cedulas.gross_receipts = tax;
            }
            return 5000;
        },
        computedState() {
            if (this.cedulas.income_amounts < 0) {
                return 0;
            }
            const tax = this.cedulas.income_amounts / 1000 | 0;
            if (tax < 5000 && tax > -1) {
                return this.cedulas.income_property = tax;
            }
            return 5000;
        },
        totalAmount() {
            const grossAmounts = parseInt(this.cedulas.gross_receipts);
            const incomeAmounts = parseInt(this.cedulas.income_property);
            const salariesAmounts = parseInt(this.cedulas.salaries_receipts);
            const basicCommTax = parseInt(this.cedulas.basic_comm_tax);
            const interest = parseInt(this.cedulas.interest);

            const safeGrossAmounts = Number.isNaN(grossAmounts) ? 0 : grossAmounts;
            const safeIncomeAmounts = Number.isNaN(incomeAmounts) ? 0 : incomeAmounts;
            const safeSalariesAmounts = Number.isNaN(salariesAmounts) ? 0 : salariesAmounts;
            const safeBasicCommTax = Number.isNaN(basicCommTax) ? 0 : basicCommTax;
            const safeInterest = Number.isNaN(interest) ? 0 : interest;

            const total = safeGrossAmounts + safeIncomeAmounts + safeSalariesAmounts + safeBasicCommTax + safeInterest;
            return total;
        },
        totalAddComm() {
            return this.cedulas.gross_receipts + this.cedulas.income_property + this.cedulas.salaries_receipts;
        }
    },
    mounted() {
        this.load();
    }
}
</script>