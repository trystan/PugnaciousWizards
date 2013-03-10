package  
{
    public class Color 
	{	
		public static function hsv(h:Number, s:Number, v:Number):uint
		{
			 var r:Number, g:Number, b:Number, i:Number, f:Number, p:Number, q:Number, t:Number;
			 h %= 360;
			 if (v == 0) 
				return rgb(0, 0, 0);
			 s /= 100;
			 v /= 100;
			 h /= 60;
			 i = Math.floor(h);
			 f = h - i;
			 p = v * (1 - s);
			 q = v * (1 - (s * f));
			 t = v * (1 - (s * (1 - f)));
			 
			 switch (i)
			 {
				 case 0: r = v; g = t; b = p; break;
				 case 1: r = q; g = v; b = p; break;
				 case 2: r = p; g = v; b = t; break;
				 case 3: r = p; g = q; b = v; break;
				 case 4: r = t; g = p; b = v; break;
				 case 5: r = v; g = p; b = q; break;
			 }
			 
			 return rgb(Math.floor(r*255), Math.floor(g*255), Math.floor(b*255));
		}
		
		public static function rgb (r:int, g:int, b:int):uint
		{
			return (255 << 24) | (r << 16) | (g << 8) | b;
		}
		
		public static function lerp(c1:int, c2:int, percent:Number):int
		{
			var r1:int = (c1 >> 16) & 0xFF;
			var g1:int = (c1 >> 8) & 0xFF;
			var b1:int = c1 & 0xFF;
			var r2:int = (c2 >> 16) & 0xFF;
			var g2:int = (c2 >> 8) & 0xFF;
			var b2:int = c2 & 0xFF;
			
			var inverse:Number = 1 - percent;
			
			return rgb(r1 * percent + r2 * inverse, g1 * percent + g2 * inverse, b1 * percent + b2 * inverse);
		}
	}
}