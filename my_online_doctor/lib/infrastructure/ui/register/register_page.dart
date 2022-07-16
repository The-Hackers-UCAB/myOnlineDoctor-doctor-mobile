//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Prokect imports:
import 'package:my_online_doctor/application/bloc/register/register_bloc.dart';
import 'package:my_online_doctor/domain/models/sign_up_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dropdown_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
import 'package:my_online_doctor/infrastructure/ui/components/text_field_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/text_form_field_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';



class RegisterPage extends StatelessWidget {
  
  static const routeName = '/register';

  RegisterPage({Key? key}) : super(key: key);


  //Controllers

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textFirstNameController = TextEditingController();
  final TextEditingController _textSecondNameController = TextEditingController();
  final TextEditingController _textSecondLastNameController = TextEditingController();
  final TextEditingController _textFirstLastNameController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();
  final TextEditingController _textConfirmPasswordController = TextEditingController();
  final TextEditingController _textPhoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => RegisterBloc(),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(context),
            body: _body(context, state),
            bottomNavigationBar: _renderBottomNavigationBar(),
          );
        },
      ),
    );
  }


  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => 
    AppBar(
      backgroundColor: colorPrimary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => {},
        // onPressed: () => Navigator.of(context).pop(),
      ),
      // leading: renderLogoImageView(context),
      title: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text('Registro de Paciente'),
      )
    );


  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar() =>
    Container(width: double.infinity, height: 30, color: colorSecondary);

  //Widget Body
  Widget _body(BuildContext context, RegisterState state) {
    
    if(state is RegisterStateInitial) {
      context.read<RegisterBloc>().add(RegisterEventFetchBasicData());
    }

    return Stack(
      children: [
        if(state is! RegisterStateInitial) _registerStreamBuilder(context),
        if(state is RegisterStateInitial || state is RegisterStateLoading) const LoadingComponent(),
      ],
    );
  }


  //StreamBuilder for the Register Page
  Widget _registerStreamBuilder(BuildContext builderContext) => StreamBuilder<bool>(
    stream: builderContext.read<RegisterBloc>().streamRegister,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

      if(snapshot.hasData) {
        return _registerRenderView(context);
      } 

      return const LoadingComponent();
    }
  );


  //Widget to create the stack of fields
  Widget _registerRenderView(BuildContext context) {

    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: generalMarginView,
              child: Container(
                child: _createRegisterFields(context)
              ),
            ),
          ),
        ),
      ],
    );
  }


  //Widget to create the fields 
  Widget _createRegisterFields(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment:  CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      renderLogoImageView(context),
      _renderPatientEmailTextField(),
      heightSeparator(context, 0.045),
      _renderPatientFirstNameTextField(),
      heightSeparator(context, 0.045),
      _renderPatientSecondNameTextField(),
      heightSeparator(context, 0.045),
      _renderPatientFirstLastNameTextField(),
      heightSeparator(context, 0.045),
      _renderPatientSecondLastNameTextField(),
      heightSeparator(context, 0.045),
      _renderPatientPhoneTextField(context),
      heightSeparator(context, 0.045),
      _renderPatientPasswordTextField(),
      heightSeparator(context, 0.045),
      _renderPatientConfirmPasswordTextField(),
      heightSeparator(context, 0.045),
      

      _renderRegisterButton(context),
    ],
  );


  Widget _renderPatientEmailTextField() => TextFieldBaseComponent(
    hintText: 'Correo Electrónico', 
    errorMessage: 'Ingrese el correo', 
    minLength: MinMaxConstant.minLengthEmail.value, 
    maxLength: MinMaxConstant.maxLengthEmail.value, 
    textEditingController: _textEmailController, 
    keyboardType: TextInputType.emailAddress,
  );


  Widget _renderPatientFirstNameTextField() => TextFieldBaseComponent(
    hintText: 'Primer Nombre', 
    errorMessage: 'Ingrese el nombre', 
    minLength: MinMaxConstant.minLengthName.value, 
    maxLength: MinMaxConstant.maxLengthName.value, 
    textEditingController: _textFirstNameController, 
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientSecondNameTextField() => TextFieldBaseComponent(
    hintText: 'Segundo Nombre', 
    errorMessage: 'Ingrese el nombre', 
    minLength: MinMaxConstant.minLengthName.value, 
    maxLength: MinMaxConstant.maxLengthName.value, 
    textEditingController: _textSecondNameController, 
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientFirstLastNameTextField() => TextFieldBaseComponent(
    hintText: 'Primer Apellido', 
    errorMessage: 'Ingrese el apellido', 
    minLength: MinMaxConstant.minLengthName.value, 
    maxLength: MinMaxConstant.maxLengthName.value, 
    textEditingController: _textFirstLastNameController, 
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientSecondLastNameTextField() => TextFieldBaseComponent(
    hintText: 'Segundo Apellido', 
    errorMessage: 'Ingrese el apellido', 
    minLength: MinMaxConstant.minLengthName.value, 
    maxLength: MinMaxConstant.maxLengthName.value, 
    textEditingController: _textSecondLastNameController, 
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientPasswordTextField() => TextFieldBaseComponent(
    hintText: 'Contraseña', 
    errorMessage: 'Ingrese la contraseña', 
    minLength: MinMaxConstant.minLengthPassword.value, 
    maxLength: MinMaxConstant.maxLengthPassword.value, 
    textEditingController: _textPasswordController, 
    obscureText: true,
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientConfirmPasswordTextField() => TextFieldBaseComponent(
    hintText: 'Confirmar Contraseña', 
    errorMessage: 'Ingrese la contraseña', 
    minLength: MinMaxConstant.minLengthPassword.value, 
    maxLength: MinMaxConstant.maxLengthPassword.value, 
    textEditingController: _textConfirmPasswordController, 
    obscureText: true,
    keyboardType: TextInputType.text,
  );


    Widget _renderPatientPhoneTextField(BuildContext context){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownComponent(
              model: DropdownComponentModel(
                dropDownLists: context.read<RegisterBloc>().phonesList.map((e) => e).toList(),
                itemDropdownSelected: context.read<RegisterBloc>().phoneSelected!,
                ),
              didChangeValue: (newValue) => context.read<RegisterBloc>().add(RegisterEventPhoneChanged(newValue)),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormFieldBaseComponent(
            errorMessage: 'Ingrese teléfono',
            hintText: 'Teléfono',
            maxLength: MinMaxConstant.minLengthPhone.value,
            minLength: MinMaxConstant.maxLengthPhone.value,
            textEditingController: _textPhoneController,
            keyboardType: TextInputType.number,
            validateSpaces: true,
          ),
        ),
      ],
    );
  }








  Widget _renderRegisterButton(BuildContext context) => Container(
    width: double.infinity,
    child: const ButtonComponent(
      title: 'Registrar',
      style: ButtonComponentStyle.primary,
      // actionButton: () => presenter.didTapRegisterButton(
      //   _formKey.currentState?.validate() ?? false, 
      //   _textPasswordController.text,
      //   _textConfirmPasswordController.text,
      // ).then((state) => _manageDidTapRegisterButtonState(state, context)),
    )
  );




}