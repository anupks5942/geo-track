import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geo_track/services/functions/auth_provider.dart';
import 'package:geo_track/utils/validators.dart';
import 'package:geo_track/widgets/features/auth/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late String _email;
  late String _password;
  late String _name;
  late String _dob;
  late String _department;
  late String _phoneNumber;
  late String _gender;
  // late String _role;

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dob =
            "${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}";
      });
    }
  }

  _onActionButtonTap() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    context.read<AuthProvider>().signUpUsingEmailAndPassword(
          name: _name,
          // role: _role,
          email: _email,
          password: _password,
          department: _department,
          dob: _dob,
          gender: _gender,
          phone: _phoneNumber,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            validator: Validators.validateName,
            onSaved: (value) {
              setState(() {
                _name = value!;
              });
            },
            decoration: const InputDecoration(
              hintText: "Name",
            ),
          ),
          SizedBox(height: 5.h),
          TextFormField(
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your department';
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                _department = value!;
              });
            },
            decoration: const InputDecoration(
              hintText: "Department",
            ),
          ),
          SizedBox(height: 5.h),
          // DropdownMenu(
          //   width: double.infinity,
          //   enableSearch: false,
          //   hintText: 'Role',
          //   onSelected: (value) {
          //     if (value != null) {
          //       setState(() {
          //         _role = value;
          //       });
          //     }
          //   },
          //   dropdownMenuEntries: const [
          //     DropdownMenuEntry(value: 'Admin', label: 'Administrator'),
          //     DropdownMenuEntry(value: 'Employee', label: 'Employee'),
          //   ],
          // ),
          // SizedBox(height: 5.h),
          DropdownMenu(
            width: double.infinity,
            enableSearch: false,
            hintText: 'Gender',
            onSelected: (value) {
              if (value != null) {
                setState(() {
                  _gender = value;
                });
              }
            },
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 'Male', label: 'Male'),
              DropdownMenuEntry(value: 'Female', label: 'Female'),
              DropdownMenuEntry(value: 'Other', label: 'Other'),
            ],
          ),
          SizedBox(height: 5.h),
          TextFormField(
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
              hintText: _selectedDate == null
                  ? "Date of Birth"
                  : "${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}",
            ),
            validator: (value) {
              if (_selectedDate == null) {
                return 'Please select your date of birth';
              }
              return null;
            },
            onSaved: (value) {
              if (_selectedDate != null) {
                _dob =
                    "${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}";
              }
            },
          ),
          SizedBox(height: 5.h),
          TextFormField(
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: TextInputType.number,
            maxLength: 10,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length != 10) {
                return 'Please enter a valid 10-digit phone number';
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                _phoneNumber = value!;
              });
            },
            decoration: const InputDecoration(
              hintText: "Phone Number",
              counterText: "", // Hides the character counter
            ),
          ),
          SizedBox(height: 5.h),
          TextFormField(
            controller: _emailController,
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            validator: Validators.validateEmail,
            onSaved: (value) {
              setState(() {
                _email = value!;
              });
            },
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          SizedBox(height: 5.h),
          TextFormField(
            controller: _passwordController,
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: Validators.validatePassword,
            obscureText: !_passwordVisible,
            onSaved: (value) {
              setState(() {
                _password = value!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              hintText: "Password",
            ),
          ),
          SizedBox(height: 10.h),
          Consumer<AuthProvider>(
            builder: (context, value, _) {
              return ActionButton(
                text: "Sign up",
                isBusy: value.isBusy,
                onPressed: _onActionButtonTap,
              );
            },
          ),
          SizedBox(height: 15.h),
          Text(
            "Already have an account?",
            style: GoogleFonts.sora(
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: context.read<AuthProvider>().toggleAuthView,
            child: Container(
              padding: EdgeInsets.symmetric(
                // horizontal: 8.w,
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[400],
                  borderRadius: BorderRadius.circular(8.r)),
              child: Center(
                child: Text(
                  "Log in",
                  style: GoogleFonts.sora(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
