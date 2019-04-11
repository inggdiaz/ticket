<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="white">
                <v-toolbar-title>List of Tickets</v-toolbar-title>
                <v-divider class="mx-2" inset vertical></v-divider>
                <v-spacer></v-spacer>
                <v-text-field
                        class="text-xs-center"
                        v-model="search"
                        append-icon="search"
                        label="Search"
                        single-line
                        hide-details
                ></v-text-field>
                <v-spacer></v-spacer>
                <v-dialog v-model="employeeDialog" max-width="500px">
                    <v-btn slot="activator" color="primary" dark class="mb-2">New</v-btn>
                    <v-card>
                        <v-card-title>
                            <span class="headline">Employee</span>
                        </v-card-title>
                        <v-card-text>
                            <v-container grid-list-md>
                                <v-layout wrap>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                disabled
                                                v-model="employee.first_name"
                                                label="First Name"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                disabled
                                                v-model="employee.last_name"
                                                label="Last Name">
                                        </v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                disabled
                                                v-model="employee.email"
                                                label="Email"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                disabled
                                                v-model="employee.status"
                                                label="Status"
                                        ></v-text-field>
                                    </v-flex>
                                </v-layout>
                            </v-container>
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="error" @click.native="employeeDialog = false">Cancel</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
                <v-dialog v-model="dialog" max-width="500px">
                    <v-btn slot="activator" color="primary" dark class="mb-2">Create Ticket</v-btn>
                    <v-card>
                        <v-card-title>
                            <span class="headline">{{ formTitle }}</span>
                        </v-card-title>
                        <v-card-text>
                            <v-container grid-list-md>
                                <v-layout wrap>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                v-validate="'required'"
                                                data-vv-scope="form-1"
                                                data-vv-name="subject"
                                                :error-messages="errors.collect('form-1.subject')"
                                                v-model="ticket.subject"
                                                label="Subject"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-menu
                                                ref="menu"
                                                v-model="menu"
                                                :close-on-content-click="false"
                                                :nudge-right="40"
                                                :return-value.sync="ticket.date"
                                                lazy
                                                transition="scale-transition"
                                                offset-y
                                                full-width
                                                min-width="290px"
                                        >
                                            <template v-slot:activator="{ on }">
                                                <v-text-field
                                                        v-model="ticket.date"
                                                        v-validate="'required'"
                                                        data-vv-name="date"
                                                        data-vv-scope="form-1"
                                                        :error-messages="errors.collect('form-1.date')"
                                                        label="Date"
                                                        prepend-icon="event"
                                                        readonly
                                                        v-on="on"
                                                ></v-text-field>
                                            </template>
                                            <v-date-picker v-model="ticket.date" no-title scrollable>
                                                <v-spacer></v-spacer>
                                                <v-btn flat color="primary" @click="menu = false">Cancel</v-btn>
                                                <v-btn flat color="primary" @click="$refs.menu.save(ticket.date)">OK
                                                </v-btn>
                                            </v-date-picker>
                                        </v-menu>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-combobox
                                                item-text="name"
                                                item-value="id"
                                                v-model="ticket.employees"
                                                v-validate="'required'"
                                                data-vv-name="employees"
                                                data-vv-scope="form-1"
                                                :error-messages="errors.collect('form-1.employees')"
                                                :items="employees"
                                                label="Select Employee(s)..."
                                                multiple
                                        ></v-combobox>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-select
                                                item-text="name"
                                                item-value="id"
                                                v-model="ticket.status_id"
                                                v-validate="'required'"
                                                data-vv-name="select"
                                                :items="status"
                                                data-vv-scope="form-1"
                                                :error-messages="errors.collect('form-1.select')"
                                                required
                                                label="Status"
                                        ></v-select>
                                    </v-flex>
                                    <v-flex xs12 sm12 md12>
                                        <v-textarea
                                                v-validate="'required'"
                                                data-vv-name="description"
                                                data-vv-scope="form-1"
                                                :error-messages="errors.collect('form-1.description')"
                                                v-model="ticket.description"
                                                solo
                                                name="input-7-4"
                                                label="Description"
                                                value=""
                                        ></v-textarea>
                                    </v-flex>
                                </v-layout>
                            </v-container>
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="success" @click.native="save">Save</v-btn>
                            <v-btn color="error" @click.native="close">Cancel</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>

                <v-dialog v-model="viewDialog" max-width="700px">
                    <v-card>
                        <v-card-title>
                            <span class="headline">Ticket #{{ ticket.id }}</span>
                        </v-card-title>
                        <v-card-text>
                            <v-container grid-list-md>
                                <v-layout wrap>
                                    <v-flex xs12 sm12 md12>
                                        <v-text-field
                                                disabled
                                                v-model="ticket.id"
                                                label="Ticket #"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                disabled
                                                v-model="ticket.subject"
                                                label="Subject"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                v-model="ticket.date"
                                                disabled
                                                label="Date"
                                                prepend-icon="event"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm12 md12>
                                        <v-textarea
                                                disabled
                                                v-model="ticket.description"
                                                solo
                                                name="input-7-4"
                                                label="Description"
                                                value=""
                                        ></v-textarea>
                                    </v-flex>
                                    <v-flex xs12 sm12 md12>
                                        <template>
                                            <div>
                                                <v-tabs
                                                        color="cyan"
                                                        dark
                                                        slider-color="yellow">
                                                    <v-tab :key="1" ripple>
                                                        Time Entries
                                                    </v-tab>
                                                    <v-tab :key="2" ripple>
                                                        Employees
                                                    </v-tab>
                                                    <v-tab-item :key="1">
                                                        <template>
                                                            <v-data-table
                                                                    :headers="headersTime"
                                                                    :items="ticket.times"
                                                                    class="elevation-1"
                                                            >
                                                                <template v-slot:items="props">
                                                                    <td>{{ props.item.employee.name }}</td>
                                                                    <td>{{ props.item.created_at }}</td>
                                                                    <td>{{ props.item.note }}</td>
                                                                    <td>
                                                                        <v-tooltip bottom>
                                                                            <template v-slot:activator="{ on }">
                                                                                <v-icon small class="mr-2" v-on="on"
                                                                                        @click="editTime(props.item)">
                                                                                    edit
                                                                                </v-icon>
                                                                            </template>
                                                                            <span>Edit</span>
                                                                        </v-tooltip>
                                                                        <v-tooltip bottom>
                                                                            <template v-slot:activator="{ on }">
                                                                                <v-icon small class="mr-2" v-on="on"
                                                                                        @click="deleteTime(props.item.id)">
                                                                                    delete_forever
                                                                                </v-icon>
                                                                            </template>
                                                                            <span>Delete</span>
                                                                        </v-tooltip>
                                                                    </td>
                                                                </template>
                                                            </v-data-table>
                                                        </template>
                                                    </v-tab-item>
                                                    <v-tab-item :key="2">
                                                        <template>
                                                            <v-data-table
                                                                    :headers="headersAssign"
                                                                    :items="ticket.assign"
                                                                    class="elevation-1"
                                                            >
                                                                <template v-slot:items="props">
                                                                    <td>{{ props.item.employee.first_name }}</td>
                                                                    <td>{{ props.item.employee.last_name }}</td>
                                                                    <td>{{ props.item.employee.email }}</td>
                                                                    <td>
                                                                        <v-tooltip bottom>
                                                                            <template v-slot:activator="{ on }">
                                                                                <v-icon small class="mr-2" v-on="on"
                                                                                        @click="viewEmployee(props.item.employee)">
                                                                                    pageview
                                                                                </v-icon>
                                                                            </template>
                                                                            <span>View</span>
                                                                        </v-tooltip>
                                                                        <v-tooltip bottom>
                                                                            <template v-slot:activator="{ on }">
                                                                                <v-icon small class="mr-2" v-on="on"
                                                                                        @click="deleteAssign(props.item.id)">
                                                                                    delete_forever
                                                                                </v-icon>
                                                                            </template>
                                                                            <span>Delete</span>
                                                                        </v-tooltip>
                                                                    </td>
                                                                </template>
                                                            </v-data-table>
                                                        </template>
                                                    </v-tab-item>
                                                </v-tabs>
                                            </div>
                                        </template>
                                    </v-flex>
                                </v-layout>
                            </v-container>
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="error" @click.native="closeView">Close</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>

                <v-dialog v-model="timeDialog" max-width="700px">
                    <v-card>
                        <v-card-title>
                            <span class="headline">Time Entry Form</span>
                        </v-card-title>
                        <v-card-text>
                            <v-container grid-list-md>
                                <v-layout wrap>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                disabled
                                                v-model="ticket.id"
                                                label="Ticket #"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                v-model="ticket.date"
                                                disabled
                                                label="Date"
                                                prepend-icon="event"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                disabled
                                                v-model="ticket.subject"
                                                label="Subject"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                disabled
                                                v-model="ticket.status"
                                                label="Status"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-divider></v-divider>
                                    <h3> Time Entry Information</h3>
                                    <v-flex xs12 sm12 md12>
                                        <v-combobox
                                                item-text="employee.name"
                                                item-value="employee.id"
                                                v-model="time.employee_id"
                                                v-validate="'required'"
                                                data-vv-name="employees"
                                                :error-messages="errors.collect('employees')"
                                                :items="ticket.assign"
                                                label="Select Employee"
                                        ></v-combobox>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-datetime-picker
                                                label="Select Datetime from"
                                                v-model="time.date_from">
                                        </v-datetime-picker>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-datetime-picker
                                                label="Select Datetime to"
                                                v-model="time.date_to">
                                        </v-datetime-picker>
                                    </v-flex>
                                    <v-flex x12 sm12 md12>
                                        <v-textarea
                                                v-validate="'required'"
                                                data-vv-name="note"
                                                :error-messages="errors.collect('note')"
                                                v-model="time.note"
                                                solo
                                                name="input-7-4"
                                                label="Note"
                                                value=""
                                        ></v-textarea>
                                    </v-flex>
                                </v-layout>
                            </v-container>
                        </v-card-text>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="success" @click.native="saveTime">Save</v-btn>
                            <v-btn color="error" @click.native="closeTime">Close</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
            </v-toolbar>
            <v-data-table :headers="headers" :items="tickets" :search="search" class="elevation-1">
                <template slot="items" slot-scope="props">
                    <td>{{ props.item.id }}</td>
                    <td>{{ props.item.description }}</td>
                    <td>
                        <v-chip v-for="assign in props.item.assign">{{assign.employee.first_name}}
                            {{assign.employee.last_name}}
                        </v-chip>
                    </td>
                    <td>{{ props.item.date}}</td>
                    <td>{{ props.item.status.name}}</td>
                    <td class="justify-center layout px-0">
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on }">
                                <v-icon small class="mr-2" v-on="on" @click="timeItem(props.item)">note_add</v-icon>
                            </template>
                            <span>Add Note</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on }">
                                <v-icon small class="mr-2" v-on="on" @click="viewItem(props.item)">pageview</v-icon>
                            </template>
                            <span>View</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on }">
                                <v-icon small class="mr-2" v-on="on" @click="editItem(props.item)">edit</v-icon>
                            </template>
                            <span>Edit</span>
                        </v-tooltip>
                        <v-tooltip bottom>
                            <template v-slot:activator="{ on }">
                                <v-icon small class="mr-2" v-on="on" @click="editItem(props.item)">delete_forever
                                </v-icon>
                            </template>
                            <span>Delete</span>
                        </v-tooltip>
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
        $_veeValidate: {
            validator: "new"
        },
        data() {
            return {
                employees: [],
                tickets: [],
                dialog: false,
                viewDialog: false,
                timeDialog: false,
                employeeDialog: false,
                headers: [
                    {text: "#", value: "#"},
                    {text: "Description", value: "description"},
                    {text: "Employee(s)", value: "employee"},
                    {text: "Date", value: "date", sortable: false},
                    {text: "Status", value: "status_id", sortable: false},
                    {text: "Actions", value: "actions", sortable: false},
                ],
                headersAssign: [
                    {text: "First Name", value: "first_name"},
                    {text: "Last Name", value: "last_name"},
                    {text: "Email", value: "email"},
                    {text: "Actions", value: "actions", sortable: false},
                ],
                headersTime: [
                    {text: "Employee", value: "employee"},
                    {text: "Date", value: "date"},
                    {text: "Note", value: "note"},
                    {text: "Actions", value: "actions", sortable: false},
                ],
                search: "",
                editedIndex: -1,
                datetime: new Date(),
                ticket: {
                    id: 0,
                    subject: '',
                    employees: [],
                    date: '',
                    status_id: null,
                    description: '',
                },
                time: {
                    id: 0,
                    employee_id: null,
                    ticket_id: null,
                    date_from: new Date(),
                    date_to: new Date(),
                    note: '',
                },
                menu: false,
                date: new Date().toISOString().substr(0, 10),
                select: [],
                status: null,
                employee: {
                    first_name: "",
                    last_name: "",
                    email: "",
                    status: "",
                },
                adId: "",
            };
        },
        computed: {
            formTitle() {
                return this.editedIndex === -1 ? "New Ticket" : "Update Ticket";
            }
        },
        watch: {
            dialog(val) {
                val || this.close();
            }
        },
        created() {
            this.list();
            this.listEmployee();
            this.listStatus();
        },
        methods: {
            list() {
                let self = this;
                axios
                    .get("api/ticket/all")
                    .then(function (response) {
                        self.tickets = response.data;
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
            },
            listEmployee() {
                axios.get('api/employee/all').then(response => {
                    this.employees = response.data;
                });
            },
            listStatus() {
                axios.get('api/ticket/status').then(response => {
                    this.status = response.data;
                });
            },
            viewItem(item) {
                this.ticket.id = item.id;
                this.ticket.subject = item.subject;
                this.ticket.description = item.description;
                this.ticket.date = item.date;
                this.ticket.assign = item.assign;
                this.ticket.times = item.times;
                this.viewDialog = true;
            },
            viewEmployee(employee) {
                console.log(employee);
                this.employee = employee;
                this.employee.status = (employee.status_id === 1) ? 'Active' : 'Disable';
                this.employeeDialog = true;
            },
            timeItem(item) {
                this.ticket.id = item.id;
                this.time.ticket_id = item.id;
                this.ticket.subject = item.subject;
                this.ticket.description = item.description;
                this.ticket.date = item.date;
                this.ticket.assign = item.assign;
                this.ticket.status = item.status.name;
                this.timeDialog = true;
            },
            editItem(item) {
                this.ticket.id = item.id;
                this.ticket.subject = item.subject;
                this.ticket.description = item.description;
                this.ticket.date = item.date;
                this.ticket.status_id = item.status_id;
                let emp = [];
                item.assign.map(data => {
                   emp.push(data.employee);
                });
                // console.log(emp);
                this.ticket.employees = emp;
                this.editedIndex = 1;
                this.dialog = true;
            },
            editTime(item) {
                this.time.id = item.id;
                this.time.ticket_id = item.ticket_id;
                this.time.employee_id = item.employee_id;
                this.time.date_from = item.from;
                this.time.date_to = item.to;
                this.time.note = item.note;
                // this.editedIndex = 1;
                this.timeDialog = true;
            },
            close() {
                this.dialog = false;
                this.cleanForm();
            },
            closeView() {
                this.viewDialog = false;
                this.cleanForm();
            },
            closeTime() {
                this.timeDialog = false;
                this.cleanForm();
            },
            cleanForm() {
                this.ticket.id = "";
                this.ticket.subject = "";
                this.ticket.description = "";
                this.ticket.date = "";
                this.ticket.status_id = null;
                this.editedIndex = -1;
            },
            save() {
                let self = this;
                console.log(this.ticket);
                // return;
                this.$validator.validateAll('form-1').then(result => {
                    if (result) {
                        if (self.employee.id > 0) {
                            self.employee.change_password = (self.employee.old_password === self.employee.password) ? 0 : 1;
                            axios.put('api/ticket/add', self.ticket).then(response => {
                                self.close();
                                self.list();
                                self.cleanForm();
                            }).catch(response => {
                                console.log('Error');
                                console.log(response);
                            });
                        } else {
                            axios.post('api/ticket/add', self.ticket).then(response => {
                                self.close();
                                self.list();
                                self.cleanForm();
                            }).catch(response => {
                                console.log('Error');
                                console.log(response);
                            });
                        }
                    } else {
                        console.log('Fill');
                    }
                });
            },
            saveTime() {
                let self = this;
                console.log(this.ticket);
                // return;
                this.$validator.validateAll().then(result => {
                    if (result) {
                        if (self.time.id > 0) {
                            axios.put('api/ticket/time', self.time).then(response => {
                                self.closeTime();
                                self.list();
                                self.cleanForm();
                                self.closeView();
                                // self.viewDialog()
                            }).catch(response => {
                                console.log('Error');
                                console.log(response);
                            });
                        } else {
                            axios.post('api/ticket/time', self.time).then(response => {
                                self.closeTime();
                                self.list();
                                self.cleanForm();
                            }).catch(response => {
                                console.log('Error');
                                console.log(response);
                            });
                        }
                    }
                });
            },
            deleteTime(id) {
                let self = this;
                axios.delete(`api/ticket/time/${id}`).then(response => {
                    self.closeTime();
                    self.list();
                    self.cleanForm();
                    self.closeView();
                });
            },
            deleteAssign(id) {
                let self = this;
                axios.delete(`api/ticket/assign/${id}`).then(response => {
                    self.closeTime();
                    self.list();
                    self.cleanForm();
                    self.closeView();
                });
            },

        }
    };
</script>
