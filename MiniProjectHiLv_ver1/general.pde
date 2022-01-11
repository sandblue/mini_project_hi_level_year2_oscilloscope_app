void serial_check(){
 if (myPort != null ){
    status_port.setText("PORT  STATUS : ON");
    // for check serial port is ava
    try {
      if(!(name == Serial.list()[0])){
        time_out = 0;
      }
     }catch (Exception e) {
       print(" port miss ");
     }
     //
    if(stop_update == false){
     if(myPort.available() > get_delay()){
      while(myPort.available() > 5){
      int in_mode = myPort.read();
      // if((in_mode) != -1){
        if((in_mode) != (mode_ch+128)){
           send_command_set_mode();
           confirm_connect = 0;
            myPort.clear();
        }else{
         int value_first;
         int value_second;
         int value_first2;
         int value_second2;
         //while(myPort.available() < 5){
        // }
         switch(in_mode){
          case 128:
            //println("mode 0");
            break;
          case 129:
            //println("mode 1");
            value_first = myPort.read();
           // time_out = 0;
           // while(value_first == -1){
           //   print("   fail to read   ");
           //   time_out++;
           //   value_first = myPort.read();
           //   if(time_out > 1000){
           //    println("time_out");
           //    value_first = 0; 
           //   }
           // }
            value_second = myPort.read();
           // time_out = 0;
           // while(value_second == -1){
           //   print("   fail to read   ");
           //   time_out++;
           //   value_second = myPort.read(); 
           //   if(time_out > 1000){
           //    println("time_out");
           //    value_second = 0; 
           //   }
           // }
            myChart.push("ch1", calculate_output_with_scale(float((value_first*100)+(value_second))/1000, scale_y_ch1));
           // println("value_first : "+value_first);
            //println("value_second : "+value_second);
            break;
          case 130:
            //println("mode 2");
            value_first = myPort.read();
           // time_out = 0;
           // while(value_first == -1){
           //   print("   fail to read   ");
           //   time_out++;
           //   value_first = myPort.read();
           //   if(time_out > 1000){
           //    println("time_out");
           //    value_first = 0; 
           //   }
           // }
            value_second = myPort.read();
           // time_out = 0;
           // while(value_second == -1){
           //   print("   fail to read   ");
           //   time_out++;
           //   value_second = myPort.read(); 
           //   if(time_out > 1000){
           //    println("time_out");
           //    value_second = 0; 
           //   }
           // }
            myChart2.push("ch2", calculate_output_with_scale(float((value_first*100)+(value_second))/1000, scale_y_ch2));
            //println("value_first : "+value_first);
            //println("value_second : "+value_second);
            break;
          case 131:
            //println("mode 3");
            value_first = myPort.read();
           // time_out = 0;
           // while(value_first == -1){
           //   print("   fail to read   ");
           //   time_out++;
          //    value_first = myPort.read();
           //   if(time_out > 1000){
          //     println("time_out");
         //      value_first = 0;
          //    }
         //   }
            value_second = myPort.read();
          //  time_out = 0;
          //  while(value_second == -1){
          //    print("   fail to read   ");
          //    time_out++;
          //    value_second = myPort.read(); 
           //   if(time_out > 1000){
          //     println("time_out");
          //     value_second = 0; 
          //    }
          //  }
            value_first2 = myPort.read();
          //  time_out = 0;
          ///  while(value_first2 == -1){
          //    print("   fail to read   ");
          //    time_out++;
          //    value_first2 = myPort.read();
          //    if(time_out > 1000){
          //     println("time_out");
          //     value_first2 = 0; 
          //    }
          //  }
            value_second2 = myPort.read();
          //  time_out = 0;
          //  while(value_second2 == -1){
          //    print("   fail to read   ");
          //    time_out++;
          //    value_second2 = myPort.read(); 
          //    if(time_out > 1000){
          //     println("time_out");
          //     value_second2 = 0; 
          //    }
          //  }
            myChart.push("ch1", calculate_output_with_scale(float((value_first*100)+(value_second))/1000, scale_y_ch1));
            myChart2.push("ch2", calculate_output_with_scale(float((value_first2*100)+(value_second2))/1000, scale_y_ch2));
            //println("value_first : "+value_first);
            //println("value_second : "+value_second);
            //println("value_first2 : "+value_first2);
            //println("value_second2 : "+value_second2);
            break;
         }
        }
      // ------------------------------------------------ //
  
     }// end while > 5
      } // end if > 10000 
   } // end stop
     // ping board
      confirm_connect++;
      if(confirm_connect == 10){
          confirm_connect = 0; 
          send_command_set_mode();
      }
  }else{
     status_port.setText("PORT  STATUS : OFF");
  }
  if(time_out >= 100){
   myPort = null;
   status_port.setText("PORT  STATUS : OFF");
   time_out = 0;
  }
  time_out++;
}

float calculate_output_with_scale(float input, float scale){
  float output = 2/float(max_row);
  output *= (range_y_max*input)/scale;
  //println(output);
  return output;
}

void send_command_set_mode(){
  myPort.write('#');
  myPort.write(str(mode_ch));
}

void check_serial_again(){
 if(Serial.list() != null){
   //delay(5);
   name = Serial.list()[0];
   myPort = new Serial(this, Serial.list()[0], 460800); //115200 = 0.0005 , 460800 = 7500, 926100 = 15000 , 921600
   delay(50);
 }
}

float get_delay(){
  float higest_time;
  if( scale_x_ch1 < scale_x_ch2){
    higest_time = scale_x_ch1;
  }else{
    higest_time = scale_x_ch2;
  }
  if(higest_time >= 0.1){
    return (0);
  }
  if(mode_ch == 3){
    return (1000); 
  }
  return (600); // size_of_data * 3 * 0.1
}