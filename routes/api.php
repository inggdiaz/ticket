<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::group([
    'prefix' => 'employee',
], function () {
    Route::get('all', 'EmployeeController@index');
    Route::post('add', 'EmployeeController@store');
    Route::put('add', 'EmployeeController@store');
    // Route::get('login/{email}/{password}', 'EmployeeController@valid');
    Route::post('login', 'EmployeeController@login');
});


Route::group([
    'prefix' => 'ticket',
], function () {
    Route::get('all', 'TicketController@index');
    Route::get('status', 'TicketController@status');
    Route::post('add', 'TicketController@store');
    Route::put('add', 'TicketController@store');
    Route::post('time', 'TicketController@saveTimes');
    Route::put('time', 'TicketController@updateTimes');
    Route::delete('{id}', 'TicketController@deletedTicket');
    Route::delete('time/{id}', 'TicketController@deletedTime');
    Route::delete('assign/{id}', 'TicketController@deletedAssign');
    Route::get('report/{from}/{to}', 'TicketController@times');
});