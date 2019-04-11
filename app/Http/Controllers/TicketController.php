<?php

namespace App\Http\Controllers;

use App\Ticket;
use App\TicketEmployee;
use App\TicketTime;
use Illuminate\Http\Request;

class TicketController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \App\Ticket[]|\Illuminate\Database\Eloquent\Collection
     */
    public function index()
    {
        //
        $tickets = \App\Ticket::all();
        foreach ($tickets as $ticket) {
            $ticket->assign;
            $ticket->times;
            foreach ($ticket->assign as $index => $employee) {
                $employee->employee;
                $employee->employee->name = $employee->employee->first_name . ' ' . $employee->employee->last_name;
            }
            foreach ($ticket->times as $index => $employee) {
                $employee->employee;
                $employee->employee->name = $employee->employee->first_name . ' ' . $employee->employee->last_name;
            }
            $ticket->status;
        }
        return $tickets;
    }

    /**
     * @return \App\Status[]|\Illuminate\Database\Eloquent\Collection
     */
    public function status()
    {
        return \App\Status::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        $employees = (object)$request->input('employees');
        $ticket = ($request->input('id') > 0) ? Ticket::find($request->input('id')) : new Ticket();
        $ticket->subject = $request->input('subject');
        $ticket->date = $request->input('date');
        $ticket->status_id = $request->input('status_id');
        $ticket->description = $request->input('description');
        $ticket->save();
        foreach ($employees as $employee) {
            $employee = (object)$employee;
            //todo Condition save/remove
            $assign = new TicketEmployee();
            $assign->employee_id = $employee->id;
            $assign->ticket_id = $ticket->id;
            $assign->save();
        }
    }

    /**
     * @param Request $request
     */
    public function saveTimes(Request $request)
    {
        $time = new TicketTime();
        $time->ticket_id = $request->input('ticket_id');
        $time->employee_id = ((object)$request->input('employee_id'))->id;
        $time->from = date("Y-m-d H:i:s", strtotime($request->input('date_from')));
        $time->to = date("Y-m-d H:i:s", strtotime($request->input('date_to')));
        $time->note = $request->input('note');
        $time->save();
    }

    /**
     * @param Request $request
     */
    public function deletedTime($id)
    {
        \App\TicketTime::destroy($id);
    }

    /**
     * @param Request $request
     */
    public function deletedAssign($id)
    {
        \App\TicketEmployee::destroy($id);
    }


    /**
     * @param Request $request
     * @return
     */
    public function updateTimes(Request $request)
    {
        $time = TicketTime::find($request->input('id'));
        $time->ticket_id = $request->input('ticket_id');
        $time->employee_id = $request->input('employee_id');
        $time->from = date("Y-m-d H:i:s", strtotime($request->input('date_from')));
        $time->to = date("Y-m-d H:i:s", strtotime($request->input('date_to')));
        $time->note = $request->input('note');
        $time->save();
        return $time;
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
