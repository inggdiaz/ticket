<?php

namespace App\Http\Controllers;

use App\Employee;
use Illuminate\Http\Request;

class EmployeeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Employee[]
     */
    public function index()
    {
        //
        $employees = Employee::all();
        foreach ($employees as $index => $employee) {
            $employee->name = $employee->first_name . ' ' . $employee->last_name;
        }
        return $employees;
    }

    // public function login($email, $password){
    //     echo "Aqui";
    //     // return Employee::where('email',$email)
    //     // ->where('password', md5($password))
    //     // ->count();
    // }

    

    public function login(Request $request){
        // echo "Aqui";
        return Employee::where('email',$request->input('email'))
        ->where('password', md5($request->input('password')))
        ->count();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $employee = ($request->input('id') > 0) ? Employee::find($request->input('id')) : new Employee();
        $employee->first_name = $request->input('first_name');
        $employee->last_name = $request->input('last_name');
        $employee->email = $request->input('email');
        $employee->status_id = $request->input('status');
        if ($request->input('change_password') == '1') {
            $employee->password = md5($request->input('password'));
        }
        $employee->save();
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
