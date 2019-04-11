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

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::group([
    'prefix' => 'employee',
], function () {
    Route::get('all', 'EmployeeController@index');
    Route::post('add', 'EmployeeController@store');
    Route::put('add', 'EmployeeController@store');
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
    Route::delete('time/{id}', 'TicketController@deletedTime');
});