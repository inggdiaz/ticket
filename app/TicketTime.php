<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

/**
 */
class TicketTime extends Model
{
    //
    protected $fillable = [
        'ticket_id', 'employee_id', 'from', 'to', 'note',
    ];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }
}
