<?php

namespace App\Models;

use Illuminate\Database\DBAL\TimestampType;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class feedback_model extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $primaryKey = "id";
    protected $table = "feedback";
    protected $fillable = [
        'id',
        'user_id',
        'text',
    ];
}
