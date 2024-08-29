<?php

namespace App\Http\Controllers\api;
use Illuminate\Support\Str;
use App\Http\Controllers\Controller;
use App\Models\feedback_model;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
class auth_controller extends Controller
{
    public function register(Request $request){
        $validate=validator::make($request->all(),[
            'name'=>'required|string',
            'email'=>'required|string',
            'password'=>'required',
        ]);
        if($validate->fails()){
            return response()->json([
                'create'=>false,
                "message" => $validate->errors()->all(),
            ]);
        }else{
            $user=User::create([
                'name'=>$request->name,
                'email'=>$request->email,
                'password' => Hash::make($request->password),
            ]);
            return response()->json([
                'data'=>$user,
                'token' => $user->createToken('secret')->plainTextToken
            ]);
        }
    }
    public function login(Request $request)
    {
        $attrs = $request->validate([
            'email'     => 'required',
            'password'  => 'required'
        ]);

        if (!Auth::attempt($attrs)) {
            return response([
                'message' => 'Invalid Credentials.'
            ], 403);
        }

        $user = User::where('email', $request['email'])->firstOrFail();

        return response([
            'user' => $user,
            'token' => $user->createToken('secret')->plainTextToken
        ], 200);
    }
    public function logout(Request $request){
        $request->user()->currentAccessToken()->delete();
        return response()->json([
            'message' => 'Successfully logged out',
        ]);
    }
    public function changes_data(Request $request){
        $user=User::find(auth()->user()->id);
        if ($request->hasFile('image')) {
            if($user->image==null){
                $image = $request->file('image');
                $imageName = Str::random(100) .'.'. $image->getClientOriginalExtension();
                $image->move(public_path('file/user/image'), $imageName);
                $user->image = $imageName;
                $user->name = $request->username;
                $user->email = $request->email;
                if($user->update()){
                    return response()->json([
                        'status'=>true,
                        'message'=>'Update Sucessfully....',
                    ]);
                }
            }
            else{
                $imagePath = public_path('file/user/image') . '/' . $user->image;
                if (file_exists($imagePath)) {
                    unlink($imagePath);
                    $image = $request->file('image');
                    $imageName = Str::random(100) .'.'. $image->getClientOriginalExtension();
                    $image->move(public_path('file/user/image'), $imageName);
                    $user->image = $imageName;
                    $user->name = $request->username;
                    $user->email = $request->email;
                    if($user->update()){
                        return response()->json([
                            'status'=>true,
                            'message'=>'Update Sucessfully....',
                        ]);
                    }
                }        
            }
        }else{
            $user->name=$request->username;
            $user->email=$request->email;
            if($user->update()){
                return response()->json([
                    'status'=>true,
                    'message'=>'Update Sucessfully....',
                ]);
            }
        }
    }
    public function feedback(Request $request){
        $user=feedback_model::create([
            'text'=>$request->text,
            'user_id'=>auth()->user()->id,
        ]);
        if($user){
            return response()->json([
                'status'=>true,
                'message'=>"Create sucessfully...",
            ]);
        }
    }
}
