<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    protected $fillable = [
        'first_name', 'last_name', 'email', 'password','status_id',
    ];

//    protected $hidden = [
//        'password'
//    ];
}
