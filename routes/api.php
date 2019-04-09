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

Route::get('/test', function(){
});

Route::group([
    'prefix' => 'employee',
], function () {
    Route::get('all', 'EmployeeController@index');
    Route::post('add', 'EmployeeController@store');
    Route::put('add', 'EmployeeController@store');
});