var start = false; //show game
var show_tutorial = false;
var enable_click_game = true;
var enable_click_tutorial = true;
var enable_t_click_game = true;
var enable_t_click_tutorial = true;
var delay = millis();
var message = 0;
var finish_ = false;


//Stone
var x_Stone
var y_Stone;
var x1_Stone;
var y1_Stone;
var x2_Stone;
var y2_Stone;

//Sun
var sun = 20;
var leftX = 45;
var rightX = 370;

/*
	x: x-coordinate of car1
	y: y-coordinate car1
	w: width car1
	h: height used for all car
	size_: screen width
*/
var x,y,x1,x2,y1,y2,c;
var size_ = 800;
var	w,w1,w2;
var	h;
var count = 1;
var car, car1, car2;
var speed, speed1, speed2;


//Cars of color object
	var Color = function(r,g,b){
		this.r = r;
		this.g = g;
		this.b = b;
	};
	
	/*
		Car object
		x: x-coordinate 
		y: y-coordinate
		w: width
		h: height
		r,g,b: car of color
	*/
	var Car = function(x,y,w,h,c,speed)(
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.c = c;
		this.speed = speed;
	};
	
	//Car of methods
	Car.prototype.draw = function(){
		noStroke();
		fill(c.r,c.g,c.b);
		rect(this.x, this.y, this.w, this.h);
		rect(this.x+this.w/3, this.y-this.w/3, this.w/4, this.h+this.w/3);
		
		fill(0,0,0);
		//left wheel
		ellipse(this.x+this.w/5,this.y+this.h,this.w/4,this.w/4);
		
		//right wheel
		ellipse(this.x+this.w*3/4,this.y+this.h,this.w/4,this.w/4);
	};
	
	//Car of speed x
	Car.prototype.run_x = function(){
		return this.speed;
	};	
	//Car of speed x
	Car.prototype.run_y = function(){
		return this.y;
	};
	
	
	
void setup()
{
    size(size_,402);
}

void draw(){  
		button_click();
		//show game
		if(start){
			initial();
			initial_road();
			var count_get_out = 0;
			finish_ = false;
			
			//condition noloop
			if(finish(x,x1,x2)){
				finish_ = true;
				if(message == 0){
					winner(max(x+w,x1+w1,x2+w2));
				}
				message = 1;
				if(delay+3000 < millis()){
					start = false;
				}
			}
			
			//first
			c = new Color(255,0,0);
			car = new Car(x,y,w,h,c,speed);
			car.draw();
			
			//second;
			
			c = new Color(0,255,0);
			car1 = new Car(x1,y1,w1,h,c,speed1);
			car1.draw();
			
			//three
			
			c = new Color(0,0,255);
			car2 = new Car(x2,y2,w2,h,c,speed2);
			car2.draw();
			
			//stone
			rect(x_Stone, y_Stone, 40, 40);
			rect(x1_Stone, y1_Stone, 50, 50);
			rect(x2_Stone, y2_Stone, 60, 60);
			

			//Dieu kien de xe chay 
			//Neu xe ko lao ra ngoai le` va khong cham vao cac xe khac thi xe do chay nguoc lai dung yen va tao vu no
			if(!handling_pavement(y) 
			&& !handling_collision(x,y,w,h,x1,y1,w1,h) 
			&& !handling_collision(x,y,w,h,x2,y2,w2,h) 
			&& !handling_collision(x,y,w,h,x_Stone,y_Stone,40,40)
			&& !handling_collision(x,y,w,h,x1_Stone,y1_Stone,50,50)
			&& !handling_collision(x,y,w,h,x2_Stone,y2_Stone,60,60)){
				if(!finish_){
					x = x+ car.run_x();
					y = y+floor(random(1,9));
				}
			}
			else{
				count_get_out++;
			}
			
			if(!handling_pavement(y1) 
			&& !handling_collision(x1,y1,w1,h,x,y,w,h) 
			&& !handling_collision(x1,y1,w1,h,x2,y2,w2,h)
			&& !handling_collision(x1,y1,w1,h,x_Stone,y_Stone,40,40)
			&& !handling_collision(x1,y1,w1,h,x1_Stone,y1_Stone,50,50)
			&& !handling_collision(x1,y1,w1,h,x2_Stone,y2_Stone,60,60)){
				if(!finish_){
					x1 =  x1+ car1.run_x();
					y1 = y1+floor(random(-2,3));
				}
			}
			else{
				count_get_out++;
			}
			
			if(!handling_pavement(y2) 
			&& !handling_collision(x2,y2,w2,h,x,y,w,h) 
			&& !handling_collision(x2,y2,w2,h,x1,y1,w1,h)
			&& !handling_collision(x2,y2,w2,h,x_Stone,y_Stone,40,40)
			&& !handling_collision(x2,y2,w2,h,x1_Stone,y1_Stone,50,50)
			&& !handling_collision(x2,y2,w2,h,x2_Stone,y2_Stone,60,60)){
				if(!finish_){
					x2 = x2 + car2.run_x();
					y2 = y2+floor(random(-3,3));
				}
			}
			else{
				count_get_out++;
			}
			
			if(count_get_out >=3){
				if(message == 0){
					println("No winner");
				}
				message = 1;
				if(delay+3000 < millis()){
					start = false;
				}
			}
		}
		//Hide game and return menu
		else{
			if(show_tutorial){
				enable_t_click_game = true;
				enable_t_click_tutorial = true;
				button_click_tutorial();
				tutorial();	
			}
			else{
				//Menu
				reset_All();
				welcome();
				//Refresh information 
				message = 0; //show only one message when round finished
				delay = millis(); //Update delay
				enable_click_game = true;
				enable_click_tutorial = true;		
			}
		}

}

/*
	x: x-coordinate
	y: y-coordinate
	w: width
	h: height
	r,g,b: car of color
*/

void initial(){
	noStroke();
	background(163,208,253);
	
	//clouds
	fill(255,255,255);
	ellipse(leftX,30,30,20);
	ellipse(leftX+17,30,15,12);
	ellipse(leftX-17,30,15,12);
	
	
	ellipse(leftX*5,30,30,20);
	ellipse(leftX*5+17,30,15,12);
	ellipse(leftX*5-17,30,15,12);
	
	ellipse(leftX*10,30,30,20);
	ellipse(leftX*10+17,30,15,12);
	ellipse(leftX*10-17,30,15,12);
	
	ellipse(leftX*15,30,30,20);
	ellipse(leftX*15+17,30,15,12);
	ellipse(leftX*15-17,30,15,12);
	
	//sun
	fill(255,170,0);
	ellipse(780,20,sun,sun);
	
}

// Draw road
void initial_road(){

	var i = 0;
	var pos = 40;
	fill(160,160,160);
	rect(0,130,800,402);
	
	//moutain
	while(i < 4){
		triangle(pos+80,80,pos,130,pos+160,130);
		pos = pos + 200;
		i++;
	}
	
	//Pavement
	fill(96,96,96);
	rect(0,130,800,30);
	
	//tree
	i = 0;
	pos = 20;
	fill(0,102,51);
	while(i < 10){
		ellipse(pos,140,30,30);
		pos = pos + 80;
		i++;
	}
	
	//line
	stroke(255,255,255);
	strokeWeight(3);
	pos = 0;
	i = 0;
	while(i<9){
		line(pos,241,pos+80,241);
		pos = pos+90;
		i++;
	}
	
	pos = 0;
	i = 0;
	while(i<9){
		line(pos,322,pos+80,322);
		pos = pos+90;
		i++;
	}	
}

//check car finish
void finish(x,x1,x2){
	if(x+w >= size_ || x1+w1 >= size_ || x2+w2 >=size_){
		return true;
	}
	return false;
}

void winner(max){
	if(x+w == max){
		println("The owner of car's red is winner");
		println(x+w);
	}
	if(x1+w1== max){
		println("The owner of car's green is winner");
		println(x1+w1);
	}
	if(x2+w2 == max){
		println("The owner of car's blue is winner");
		println(x2+w2);
	}
}

//check collision cars and stone
boolean handling_collision(x,y,w,h,x1,y1,w1,h1){
	if((y >= y1 && y<= y1+h1) || (y+h >= y1 && y+h <= y1+h1)){
		//toa do x (duoi xe 1) nam trong khoang cach x1 va x1+w1 ( do rong cua xe 2)
		if(	(x>=x1 && x <= x1+w1)
			||
			((x+w)<= (x1+w1) && (x+w) >=x1 )) //Dau xe 1 nam trong do rong xe 2
		{
			fill(255,51,51);
			ellipse((x+x1)/2,y,40,40);
			return true;
		}
	}
	
	return false;
}

//Xe vuot ra ngoai le`
boolean handling_pavement(y){
	if(y < 130 || y > 402){
		fill(255,51,51);
		ellipse(x,y,40,40);
		return true;
	}
	return false;
}

/*
	Welcome Racing Car
	start = false;
*/
void welcome(){
	background(224,224,224);
	textSize(40);
	fill(153,76,0);
	text("Racing Car", size_/2.7, 402/5);
	
	//play button
	fill(246,246,246);
	stroke(224,224,224);
	rect(size_/4, 402/3, size_/6 , 402/5);
	fill(192,192,192);
	text("Play", size_/3.7, 402/2.2);

	//tutorial button
	fill(246,246,246);
	stroke(224,224,224);
	rect(size_/1.7, 402/3, size_/6 , 402/5);
	fill(192,192,192);
	text("Tutorial", size_/1.7, 402/2.2);
}

//Click vao nut play se choi, vao huong dan se hien thi huong dan
void button_click(){
	if(mousePressed && mouseButton == LEFT){
		if(enable_click_game){
			//click play button
			if(mouseX >= size_/4 
			&& mouseX <= size_/4+size_/6
			&& mouseY >= 402/3 
			&& mouseY <=402/3+402/5){
				start = true; // show game
				show_tutorial = false;
				enable_click_game = false;
				enable_click_tutorial = false;
			}
		}
		
		//click tutorial button
		if(enable_click_tutorial){
			if(mouseX >= size_/1.7 
			&& mouseX <= size_/1.7+size_/6
			&& mouseY >= 402/3 
			&& mouseY <=402/3+402/5){
				show_tutorial = true;
				start = false;
				enable_click_game = false;
				enable_click_tutorial = false;
			}
		}
	}
}

void tutorial(){
	background(224,224,224);
	textSize(40);
	fill(153,76,0);
	text("Tutorial", size_/2.7, 402/8);

	//Content
	textSize(12);
	fill(0,0,0);
	text("1 Bấm play để chơi. ", size_/8, 402/5);
	text("2 Có 3 xe màu sắc kích thước tốc độ khác nhau.", size_/8, 402/4);
	text("3 Nếu xe chạy ra ngoài lề hoặc tông vào xe khác hoặc tông vào đá sẽ bị nổ và dừng lại => thua cuộc", size_/8, 402/3.3);
	text("4 xe nào về đích nhanh nhất sẽ chiến thắng và có thông báo phía dưới", size_/8, 402/2.7);
	text("5 Có 3 xe màu sắc kích thước tốc độ khác nhau.", size_/8, 402/2.4);
	text("6 Nếu không có xe nào về đích => xuất hiện thông báo ở dưới", size_/8, 402/2.2);
	text("7 Sau khi hết game thì chờ 3s để tự động quay về menu nếu game kết thúc trong 1s", size_/8, 402/2);

	//play button
	textSize(40);
	fill(246,246,246);
	stroke(224,224,224);
	rect(size_/4, 402/1.7, size_/6 , 402/5);
	fill(192,192,192);
	text("Play", size_/3.6, 402/1.4);

	//tutorial button
	fill(246,246,246);
	stroke(224,224,224);
	rect(size_/1.7, 402/1.7, size_/6 , 402/5);
	fill(192,192,192);
	text("Back", size_/1.6, 402/1.4);
}

//button in tutorial page
void button_click_tutorial(){
	if(mousePressed && mouseButton == LEFT){
		//click play
		if(enable_t_click_game){
			//click play button
			if(mouseX >= size_/4 
			&& mouseX <= size_/4+size_/6
			&& mouseY >= 402/1.7
			&& mouseY <=402/1.7+402/5){
				start = true; // show game
				show_tutorial = false;
				enable_t_click_game = false;
				enable_t_click_tutorial = false;
			}
		}
		
		//click back button
		if(enable_t_click_tutorial){
			if(mouseX >= size_/1.7 
			&& mouseX <= size_/1.7+size_/6
			&& mouseY >= 402/1.7
			&& mouseY <=402/1.7+402/5){
				show_tutorial = false;
				start = false;
				enable_t_click_game = false;
				enable_t_click_tutorial = false; 
			}
		}
	}
}

void reset_All(){

	x_Stone = floor(random(130,800));
	y_Stone = floor(random(160,402));

	x1_Stone = floor(random(130,800));
	y1_Stone = floor(random(160,402));

	x2_Stone = floor(random(130,800));
	y2_Stone = floor(random(160,402));
	h = floor(random(10,12));

	speed = floor(random(1,20));
	w = floor(random(40,80));
	x = floor(random(1,20));
	orgW = w/2;
	y = floor(random(150,200));


	speed1 = floor(random(1,20));
	w1 = floor(random(50,110));
	x1 = floor(random(1,10));
	orgW1 = w1/2;
	y1 = floor(random(250,300));


	speed2 = floor(random(1,20));
	w2 = floor(random(60,100));
	x2 = floor(random(1,10));
	orgW2 = w2/2;
	y2 = floor(random(350,380));
}


