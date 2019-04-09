<?php

use Illuminate\Database\Seeder;

class StatusSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        \App\Status::truncate();
        \App\Status::create(
            [
                'name' => 'Open',
            ]
        );
        \App\Status::create(
            [
                'name' => 'Complete',
            ]
        );
    }
}
