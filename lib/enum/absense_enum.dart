enum AbsenseEnum {
 checkin,
 checkout;

 String get message {
   return switch (this) {
     checkin => 'Present In',
     checkout => 'Present Out',
   };
 }
}