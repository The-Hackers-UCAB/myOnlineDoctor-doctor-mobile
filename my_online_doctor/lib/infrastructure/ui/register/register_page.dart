//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Prokect imports:
import 'package:my_online_doctor/application/bloc/register/register_bloc.dart';
import 'package:my_online_doctor/domain/models/sign_up_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
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


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => RegisterBloc(),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(),
            body: _body(context, state),
            bottomNavigationBar: _renderBottomNavigationBar(),
          );
        },
      ),
    );
  }


  ///Widget AppBar
  PreferredSizeWidget _renderAppBar() => 
    AppBar(
      backgroundColor: colorPrimary,
      title: const Center(child:  Text('Registro de Paciente'))
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
        // return _manageRegisterStates(snapshot.data! ,builderContext);
      } 

      return const LoadingComponent();
    }
  );


  //Widget to manage the states of the Bloc
  // Widget _manageRegisterStates(RegisterState state, BuildContext context ) {

  //   if(state is RegisterStateDataFetched) {
  //     return _registerRenderView(context);

  //   } else {

  //     return const LoadingComponent();
  //   }
  // }


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
      _renderRegisterButton(context),

    ],
  );



    Widget _renderPatientEmailTextField() => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormFieldBaseComponent(
          hintText: 'Correo Electrónico',
          errorMessage: 'Ingrese el correo',
          minLength: MinMaxConstant.minLengthEmail.value, 
          maxLength: MinMaxConstant.maxLengthEmail.value, 
          textEditingController: _textEmailController,
          keyboardType: TextInputType.emailAddress,
        )
      ],
    );


  Widget _renderPatientFirstNameTextField() => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormFieldBaseComponent(
          hintText: 'Primer Nombre',
          errorMessage: 'Ingrese el nombre',
          minLength: MinMaxConstant.minLengthName.value, 
          maxLength: MinMaxConstant.maxLengthName.value, 
          textEditingController: _textFirstNameController,
          keyboardType: TextInputType.text,
        )
      ],
    );



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