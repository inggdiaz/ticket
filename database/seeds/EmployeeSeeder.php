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
//        \App\Employee::create(
//
//        );
        // \App\Roles::truncate();
        // \App\Roles::create([
        //     'name' => 'admin',
        //     'active' => 't',
        // ]);
        // \App\Roles::create([
        //     'name' => 'normal',
        //     'active' => 't',
        // ]);
    }
}
