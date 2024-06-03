<template>
    <div class="d-flex flex-column ga-3 ma-5">
        <v-row class="d-flex justify-space-between">
            <v-col cols="2">
                <Form icon="mdi-receipt-text-plus-outline" titleBox="New Cedula" :fetchData="fetchData" />
            </v-col>
            <v-col cols="3">
                <v-text-field v-model="search" density="compact" label="Search" prepend-inner-icon="mdi-magnify"
                    variant="solo-filled" flat hide-details single-line></v-text-field>
            </v-col>
        </v-row>
        <Table :search="search" ref="table" />
    </div>
</template>
<script>


export default {
    data() {
        return {
            search: '',
        }
    },
    methods: {
        fetchData() {
            this.$refs.table.fetchData();
        }
    }
}
</script>