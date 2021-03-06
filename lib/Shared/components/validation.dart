
 class Validation {
   var value;

   Validation({this.value});

   static emailValidation(value) {
     String raw = value.toString().trim();
     var isSpace = raw.contains(" ");
     var strSplit = raw.split('@');
     var strCount = strSplit.length;
     var findDot = strSplit.last.split('.');
     var dotCount = findDot.length;

     var domainExist = findDot.last.contains(RegExp("[a-z]"));
     if (raw.isEmpty || raw.length < 15 || strCount > 2 || strCount == 1 ||
         dotCount == 1 || domainExist == false || isSpace == true) {
       return 'Please enter a valid email';
     }
     return null;
   }

   static passwordValidation(value) {
     String raw = value.toString().trim();

     var checkPass = raw.contains(RegExp(r"^(?=.*?[a-z])(?=.*?[0-9]).{6,}$"));
     if (raw.length <= 6) {
       return 'Please enter a password with more than 6 characters';
     }
     if (checkPass == false) {
       return 'Password must contain at least a number & a uppercase letter';
     }
     return null;
   }

   static passwordConfirmValidation(value, prevpass) {
     String raw = value.toString().trim();
     String rawprev = prevpass.toString().trim();

     if (raw != rawprev || raw.isEmpty) {
       return 'The passwords must match';
     }
     return null;
   }


   static nameValidation(value) {
     String raw = value.toString().trim();
     List<String> nameSplit = raw.split(" ");
     int spaceCounter = 0;
     for (String name in nameSplit) {
       name == "" ? spaceCounter++ : "";
     }
     bool checkName = raw.contains(RegExp(r"^[a-zA-Z\s]+$"));
     if (raw.length <= 8) {
       return 'Please enter your full name';
     }
     else if (checkName == false || spaceCounter > 0) {
       return 'Please enter a valid name';
     }
     return null;
   }

   static phoneValidation(value) {
     String raw = value.toString().trim();
     if (raw.length < 10 || raw.length > 10) {
       return 'Please enter valid phone';
     }
     return null;
   }

   static adhaarValidation(value) {
     String raw = value.toString().trim();
     if (raw.length < 12 || raw.length > 12) {
       return 'Please enter valid adhaar no';
     }
     return null;
   }

   static profileTypeValidation(value) {
     String raw = value.toString().trim();
     if (raw == 'null') {
       return 'Please Enter Profile Type';
     }
     return null;
   }

   static genderValidation(value) {
     String raw = value.toString().trim();
     if (raw == 'null') {
       return 'Please Enter Gender';
     }
     return null;
   }

   static locCityValidation(value){
     String raw = value.toString().trim();
     if(raw=='null'){
       return 'Please enter city';
     }
     return null;
   }

  static locAddressValidation(value){
    int raw = value.toString().trim().length;
    if(raw<=6){
      return 'Please enter address';
    }
    return null;
  }
  


 static cardNoValidation(value){
   int raw = value.toString().trim().length;
   if(raw < 16){
     return 'Please Enter Valid Card Number';
   }
   return null;
 }

 static cvvValidation(value){
   int raw = value.toString().trim().length;
   if(raw < 3){
     return 'Please Enter Valid CVV';
   }
   return null;
 }

   static expiryValidation(value){
     int raw = value.toString().trim().length;
     if(raw < 5){
       return 'Please Enter Valid Expiry Date';
     }
     return null;
   }


   static cardNameValidation(value){
     int raw = value.toString().trim().length;
     if(raw < 6 ){
       return 'Please Enter Valid Name';
     }
     return null;
   }

 }