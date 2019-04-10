<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TicketEmployee extends Model
{
    //
    protected $fillable = [
        'ticket_id', 'employee_id'
    ];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }
}
