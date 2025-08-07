<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Doctor extends Model
{
    use HasFactory;

    protected $fillable =[
        'name',
        'specialization_id',
        'photo'
    ];

    public function appointments() {
        return $this->hasMany(Appointment::class);
    }

    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }
    
}
