<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Build extends Model
{
    protected $guarded = ['id'];

    public function items()
    {
        return $this->hasMany(BuildItem::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
