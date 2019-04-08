<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="white">
                <v-toolbar-title>Employee</v-toolbar-title>
                <v-divider class="mx-2" inset vertical></v-divider>
                <v-spacer></v-spacer>
                <v-text-field
                        class="text-xs-center"
                        v-model="search"
                        append-icon="search"
                        label="Búsqueda"
                        single-line
                        hide-details
                ></v-text-field>
                <v-spacer></v-spacer>
                <v-dialog v-model="dialog" max-width="500px">
                    <v-btn slot="activator" color="primary" dark class="mb-2">Nuevo</v-btn>
                    <v-card>
                        <v-card-title>
                            <span class="headline">{{ formTitle }}</span>
                        </v-card-title>

                        <v-card-text>
                            <v-container grid-list-md>
                                <v-layout wrap>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field v-validate="'required'" data-vv-name="first_name" :error-messages="errors.collect('first_name')" v-model="employee.first_name" label="First Name"></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field v-model="employee.last_name" label="Last Name"></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field v-model="employee.email" :rules="[rules.required, rules.email]" label="Email"></v-text-field>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-select item-text="name" item-value="id" v-model="employee.status" :items="status" label="Status"></v-select>
                                    </v-flex>
                                    <v-flex xs12 sm6 md6>
                                        <v-text-field v-validate="'required'" data-vv-name="password" :type="'password'" v-model="employee.password" label="Password"></v-text-field>
                                    </v-flex>

                                    <v-flex xs12 sm6 md6>
                                        <v-text-field v-validate="'required|confirmed:password'" :type="'password'" data-vv-as="password" data-vv-name="confirm_password" v-model="employee.confirm_password" label="Confirm Password"></v-text-field>
                                    </v-flex>
                                    <!--                                    <v-flex xs12 sm6 md6>-->
                                    <!--                                        <v-select v-model="tipo_documento" :items="documentos" label="Tipo Documento"></v-select>-->
                                    <!--                                    </v-flex>-->
                                    <v-flex xs12 sm12 md12 v-show="valida">
                                        <div class="red--text" v-for="v in validaMensaje" :key="v" v-text="v"></div>
                                    </v-flex>
                                </v-layout>
                            </v-container>
                        </v-card-text>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="blue darken-1" flat @click.native="close">Cancelar</v-btn>
                            <v-btn color="blue darken-1" flat @click.native="guardar">Guardar</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
            </v-toolbar>
            <v-data-table :headers="headers" :items="clientes" :search="search" class="elevation-1">
                <template slot="items" slot-scope="props">
                    <td class="justify-center layout px-0">
                        <v-icon small class="mr-2" @click="editItem(props.item)">edit</v-icon>
                    </td>
                    <td>{{ props.item.nombre }}</td>
                    <td>{{ props.item.tipo_persona }}</td>
                    <td>{{ props.item.tipo_documento }}</td>
                    <td>{{ props.item.num_documento }}</td>
                    <td>{{ props.item.direccion }}</td>
                    <td>{{ props.item.telefono }}</td>
                    <td>{{ props.item.email }}</td>
                </template>
                <template slot="no-data">
                    <v-btn color="primary" @click="listar">Resetear</v-btn>
                </template>
            </v-data-table>
        </v-flex>
    </v-layout>
</template>
<script>
    import axios from "axios";

    // Vue.use(VeeValidate);
    export default {
        $_veeValidate: {
            validator: 'new'
        },
        data() {
            return {
                clientes: [],
                dialog: false,
                headers: [
                    {text: "Opciones", value: "opciones", sortable: false},
                    {text: "Nombre", value: "nombre"},
                    {text: "Tipo Persona", value: "tipo_persona"},
                    {text: "Tipo Documento", value: "tipo_documento"},
                    {text: "Número Documento", value: "num_documento", sortable: false},
                    {text: "Dirección", value: "direccion", sortable: false},
                    {text: "Teléfono", value: "telefono", sortable: false},
                    {text: "Email", value: "email", sortable: false}
                ],
                search: "",
                editedIndex: -1,
                employee: {
                    id: 0,
                    first_name: '',
                    last_name: '',
                    email: '',
                    status: 0,
                    password: '',
                    confirm_password: '',
                },
                rules: {
                    required: value => !!value || 'Required.',
                    counter: value => value.length <= 20 || 'Max 20 characters',
                    email: value => {
                        const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                        return pattern.test(value) || 'Invalid e-mail.'
                    }
                },
                id: "",
                nombre: "",
                tipo_documento: "",
                status: [{id: 1, name: 'Open'}, {id: 2, name: 'Complete'}, {id: 3, name: 'Close'}],
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
                adId: "",
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
            // this.listar();
        },
        methods: {
            listar() {
                let me = this;
                let header = {Authorization: "Bearer " + this.$store.state.token};
                let configuracion = {headers: header};
                axios
                    .get("api/Personas/ListarClientes", configuracion)
                    .then(function (response) {
                        //console.log(response);
                        me.clientes = response.data;
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
            },
            editItem(item) {
                this.id = item.idpersona;
                this.nombre = item.nombre;
                this.tipo_documento = item.tipo_documento;
                this.num_documento = item.num_documento;
                this.direccion = item.direccion;
                this.telefono = item.telefono;
                this.email = item.email;
                this.editedIndex = 1;
                this.dialog = true;
            },
            close() {
                this.dialog = false;
                this.limpiar();
            },
            limpiar() {
                this.id = "";
                this.nombre = "";
                this.tipo_documento = "";
                this.num_documento = "";
                this.direccion = "";
                this.telefono = "";
                this.email = "";
                this.editedIndex = -1;
            },
            guardar() {
                this.$validator.validateAll();
                return;
                if (this.validar()) {
                    return;
                }
                let header = {Authorization: "Bearer " + this.$store.state.token};
                let configuracion = {headers: header};
                if (this.editedIndex > -1) {
                    //Código para editar
                    let me = this;
                    axios
                        .put(
                            "api/Personas/Actualizar",
                            {
                                idpersona: me.id,
                                tipo_persona: "Cliente",
                                nombre: me.nombre,
                                tipo_documento: me.tipo_documento,
                                num_documento: me.num_documento,
                                direccion: me.direccion,
                                telefono: me.telefono,
                                email: me.email
                            },
                            configuracion
                        )
                        .then(function (response) {
                            me.close();
                            me.listar();
                            me.limpiar();
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                } else {
                    //Código para guardar
                    let me = this;
                    axios
                        .post(
                            "api/Personas/Crear",
                            {
                                tipo_persona: "Cliente",
                                nombre: me.nombre,
                                tipo_documento: me.tipo_documento,
                                num_documento: me.num_documento,
                                direccion: me.direccion,
                                telefono: me.telefono,
                                email: me.email
                            },
                            configuracion
                        )
                        .then(function (response) {
                            me.close();
                            me.listar();
                            me.limpiar();
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                }
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
