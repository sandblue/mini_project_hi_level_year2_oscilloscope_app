// draw box options
void drawBox(){
  stroke(shade3);
  fill(shade4);
  rect(x_app+50, y_app+550, 490 ,240);
  rect(x_app+720, y_app+550, 490 ,240);
  rect(x_app+80, y_app+5, 140, 70);
  rect(x_app+280, y_app+5, 140, 70);
  fill(shade4);
  rect(x_app+550, y_app+550, 160, 240);
  fill(shade5);
  stroke(shade1);
  rect(x_app+175, y_app+650, 120, 50);
  rect(x_app+175, y_app+720, 120, 50);
  rect(x_app+580, y_app+625, 100, 40);
  rect(x_app+580, y_app+735, 100, 40);
  rect(x_app+855, y_app+650, 120, 50);
  rect(x_app+855, y_app+720, 120, 50);
  fill(255);
  rect(x_app+80, y_app+80, 1100, 450);
}

void drawGrid(){
  stroke(shade2);
  for(int colum = 0 ; colum < max_colum ; colum ++){
     line(x_app+80+(colum*multiple_of_colum), y_app+80, x_app+80+(colum*multiple_of_colum), y_app+529);
  }
  for(int row = 0 ; row <= max_row ; row ++){
     line(x_app+80 , y_app+80+(row*multiple_of_row), x_app+1180, y_app+80+(row*multiple_of_row));
  }
  stroke(0);
  line(x_app+80, y_app+305, x_app+80+1100, y_app+305);
}