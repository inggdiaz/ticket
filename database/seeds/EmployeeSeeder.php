<?php

use Illuminate\Database\Seeder;

class EmployeeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        \App\Employee::truncate();
        \App\Employee::create(
            [
                'first_name' => 'Geronimo',
                'last_name' => 'Diaz',
                'email' => 'ing.geronimodiaz@gmail.com',
                'status_id' => 1,
                'password' => md5('123456'),
            ]
        );
        \App\Employee::create(
            [
                'first_name' => 'Daniel',
                'last_name' => 'Nuñez',
                'email' => 'daniel@gmail.com',
                'status_id' => 1,
                'password' => md5('123456'),
            ]
        );
        \App\Employee::create(
            [
                'first_name' => 'Efrain',
                'last_name' => 'Paulino',
                'email' => 'efrain@gmail.com',
                'status_id' => 1,
                'password' => md5('123456'),
            ]
        );
        \App\Employee::create(
            [
                'first_name' => 'Ana Judit',
                'last_name' => 'Diaz',
                'email' => 'ana@gmail.com',
                'status_id' => 1,
                'password' => md5('123456'),
            ]
        );
    }
}
