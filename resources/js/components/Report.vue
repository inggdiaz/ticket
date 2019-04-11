<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="white">
                <v-toolbar-title>Report</v-toolbar-title>
                <v-divider
                        class="mx-2"
                        inset
                        vertical
                ></v-divider>
                <v-spacer></v-spacer>
                <v-flex xs12 lg5>
                    <v-menu
                            ref="menu1"
                            v-model="menu1"
                            :close-on-content-click="false"
                            :nudge-right="40"
                            lazy
                            transition="scale-transition"
                            offset-y
                            full-width
                            max-width="290px"
                            min-width="290px"
                    >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                                    v-model="from"
                                    label="From"
                                    persistent-hint
                                    prepend-icon="event"
                                    readonly
                                    v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker v-model="from" no-title scrollable>
                            <v-spacer></v-spacer>
                            <v-btn flat color="primary" @click="menu1 = false">Cancel</v-btn>
                            <v-btn flat color="primary" @click="$refs.menu1.save(from)">OK
                            </v-btn>
                        </v-date-picker>
                    </v-menu>
                </v-flex>
                <v-flex xs12 lg5>
                    <v-menu
                            ref="menu2"
                            v-model="menu2"
                            :close-on-content-click="false"
                            :nudge-right="40"
                            lazy
                            transition="scale-transition"
                            offset-y
                            full-width
                            max-width="290px"
                    >
                        <template v-slot:activator="{ on }">
                            <v-text-field
                                    v-model="to"
                                    label="To"
                                    persistent-hint
                                    prepend-icon="event"
                                    readonly
                                    v-on="on"
                            ></v-text-field>
                        </template>
                        <v-date-picker v-model="to" no-title scrollable>
                            <v-spacer></v-spacer>
                            <v-btn flat color="primary" @click="menu2 = false">Cancel</v-btn>
                            <v-btn flat color="primary" @click="$refs.menu2.save(to)">OK
                            </v-btn>
                        </v-date-picker>
                    </v-menu>
                </v-flex>
                <v-btn v-if="from !== null || from !== ''" @click="list()" color="primary" dark class="mb-2">Generate</v-btn>
            </v-toolbar>
            <v-data-table :headers="headers" :items="tickets" :search="search" class="elevation-1">
                <template slot="items" slot-scope="props">
                    <td>{{ props.item.ticket_id }}</td>
                    <td>{{ props.item.employee.name}}</td>
                    <td>{{ props.item.note}}</td>
                    <td>{{ props.item.from}}</td>
                    <td>{{ props.item.to}}</td>
                    <td>{{ new Date(props.item.to).getHours() - new Date(props.item.from).getHours() }}</td>
                </template>
                <template v-slot:footer>
                    <td :colspan="headers.length">
                        <strong>Total: {{total =(calcTotal)}}</strong>
                    </td>
                </template>
                <template slot="no-data">
                    <v-btn color="primary" @click="list">Resetear</v-btn>
                </template>
            </v-data-table>
        </v-flex>
    </v-layout>
</template>
<script>
    import axios from "axios";

    export default {
        data() {
            return {
                employees: [],
                tickets: [],
                headers: [
                    {text: "Ticket#", value: "#"},
                    {text: "Employee", value: "employee"},
                    {text: "Note", value: "note"},
                    {text: "Date Start", value: "date_start", sortable: false},
                    {text: "Date End", value: "date_end", sortable: false},
                    {text: "Hours", value: "hours", sortable: false},
                ],
                total: 0,
                search: "",
                from: new Date().toISOString().substr(0, 10),
                to: new Date().toISOString().substr(0, 10),
                date: new Date().toISOString().substr(0, 10),
                menu1: false,
                menu2: false,
                adId: "",
            };
        },
        computed: {
            calcTotal: function () {
                let total = 0;
                this.tickets.map(time => {
                    total += new Date(time.to).getHours() - new Date(time.from).getHours();
                });
                return total;
            },
            restDate: function () {
                let fecha1 = new Date('2019/04/10');
                let fecha2 = new Date()

                let resta = fecha2.getTime() - fecha1.getTime()
                console.log(Math.round(resta / (1000 * 60 * 60)))
            }
        },
        watch: {},
        created() {
            this.list();
        },
        methods: {
            list() {
                let self = this;
                axios
                    .get(`api/ticket/report/${self.from}/${self.to}`)
                    .then(function (response) {
                        self.tickets = response.data;
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
            },
        }
    };
</script>
