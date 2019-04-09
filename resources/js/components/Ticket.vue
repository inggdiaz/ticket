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
                                                data-vv-name="subject"
                                                :error-messages="errors.collect('subject')"
                                                v-model="ticket.subject"
                                                label="Subject"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                v-model="ticket.date"
                                                v-validate="'required'"
                                                data-vv-name="date"
                                                :error-messages="errors.collect('date')"
                                                label="Date">
                                        </v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                v-model="ticket.employees"
                                                v-validate="'required'"
                                                data-vv-name="employee"
                                                :error-messages="errors.collect('employee')"
                                                label="Employess"
                                        ></v-text-field>
                                        <v-flex xs12>
                                            <v-combobox
                                                    v-model="select"
                                                    :items="items"
                                                    label="Select a favorite activity or create a new one"
                                                    multiple
                                            ></v-combobox>
                                        </v-flex>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-select
                                                item-text="name"
                                                item-value="id"
                                                v-model="employee.status"
                                                v-validate="'required'"
                                                data-vv-name="select"
                                                :items="status"
                                                :error-messages="errors.collect('select')"
                                                required
                                                label="Status"
                                        ></v-select>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                v-validate="'required'"
                                                ref="password"
                                                data-vv-name="password"
                                                :type="'password'"
                                                :error-messages="errors.collect('password')"
                                                v-model="employee.password"
                                                label="Password"
                                        ></v-text-field>
                                    </v-flex>

                                    <v-flex xs12 sm6 md6>
                                        <v-text-field
                                                v-validate="'required|confirmed:password'"
                                                :type="'password'"
                                                data-vv-as="password"
                                                :error-messages="errors.collect('confirm_password')"
                                                data-vv-name="confirm_password"
                                                v-model="employee.confirm_password"
                                                label="Confirm Password"
                                        ></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm12 md12 v-show="valida">
                                        <div class="red--text" v-for="v in validaMensaje" :key="v" v-text="v"></div>
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
            </v-toolbar>
            <v-data-table :headers="headers" :items="employees" :search="search" class="elevation-1">
                <template slot="items" slot-scope="props">
                    <td>{{ props.item.first_name }}</td>
                    <td>{{ props.item.last_name }}</td>
                    <td>{{ props.item.email }}</td>
                    <td>{{ props.item.created_at }}</td>
                    <td>{{ props.item.status_id === 1 ? 'Active': 'Disable' }}</td>
                    <td class="justify-center layout px-0">
                        <v-icon small class="mr-2" @click="editItem(props.item)">edit</v-icon>
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
                dialog: false,
                headers: [
                    {text: "#", value: "#"},
                    {text: "Description", value: "description"},
                    {text: "Employee", value: "employee"},
                    {text: "Date", value: "date", sortable: false},
                    {text: "Status", value: "status_id", sortable: false},
                    {text: "Actions", value: "actions", sortable: false},
                ],
                search: "",
                editedIndex: -1,
                ticket: {
                    id: 0,
                    subject: '',
                    employees: [],
                    date: '',
                    status_id: null,
                    description: '',
                },
                select: ['Vuetify', 'Programming'],
                items: [
                    'Programming',
                    'Design',
                    'Vue',
                    'Vuetify'
                ],
                employee: {
                    id: 0,
                    first_name: "",
                    last_name: "",
                    email: "",
                    status: null,
                    password: "",
                    confirm_password: "",
                    change_password: 1,
                    old_password: "",
                },
                id: "",
                nombre: "",
                tipo_documento: "",
                status: [{id: 1, name: "Active"}, {id: 2, name: "Disable"}],
                documentos: ["DNI", "RUC", "PASAPORTE", "CEDULA"],
                num_documento: "",
                direccion: "",
                telefono: "",
                email: "",
                valida: 0,
                validaMensaje: [],
                adModal: 0,
                adAccion: 0,
                adNombre: "",
                adId: ""
            };
        },
        computed: {
            formTitle() {
                return this.editedIndex === -1 ? "New Employee" : "Update Employee";
            }
        },
        watch: {
            dialog(val) {
                val || this.close();
            }
        },
        created() {
            // this.list();
        },
        methods: {
            list() {
                let self = this;
                axios
                    .get("api/employee/all")
                    .then(function (response) {
                        self.employees = response.data;
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
            },
            editItem(item) {
                this.employee.id = item.id;
                this.employee.first_name = item.first_name;
                this.employee.last_name = item.last_name;
                this.employee.email = item.email;
                this.employee.password = item.password;
                this.employee.confirm_password = item.password;
                this.employee.old_password = item.password;
                this.employee.status = item.status_id;
                this.editedIndex = 1;
                this.dialog = true;
            },
            close() {
                this.dialog = false;
                this.cleanForm();
            },
            cleanForm() {
                this.employee.id = "";
                this.employee.first_name = "";
                this.employee.last_name = "";
                this.employee.employee = "";
                this.employee.password = "";
                this.employee.confirm_password = "";
                this.editedIndex = -1;
            },
            save() {
                let self = this;
                this.$validator.validateAll().then(result => {
                    if (result) {
                        if (self.employee.id > 0) {
                            self.employee.change_password = (self.employee.old_password === self.employee.password) ? 0 : 1;
                            axios.put('api/employee/add', self.employee).then(response => {
                                self.close();
                                self.list();
                                self.cleanForm();
                            }).catch(response => {
                                console.log('Error');
                                console.log(response);
                            });
                        } else {
                            axios.post('api/employee/add', self.employee).then(response => {
                                console.log(response);
                                self.close();
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
            validar() {
                this.valida = 0;
                this.validaMensaje = [];

                if (this.nombre.length < 3 || this.nombre.length > 100) {
                    this.validaMensaje.push(
                        "El nombre debe tener más de 3 caracteres y menos de 100 caracteres."
                    );
                }
                if (!this.tipo_documento) {
                    this.validaMensaje.push("Seleccione un tipo documento.");
                }
                if (this.validaMensaje.length) {
                    this.valida = 1;
                }
                return this.valida;
            }
        }
    };
</script>
