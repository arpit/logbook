/*

The MIT License

Copyright (c) 2008 Comcast Interactive Media

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/
package cim.fx.logging.skins
{
    
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    
    import mx.core.EdgeMetrics;
    import mx.skins.halo.HaloBorder;
    import mx.utils.ColorUtil;
    import mx.utils.GraphicsUtil;
    
    public class GradientBorder extends HaloBorder 
    {
        
        private var topCornerRadius:Number;        // top corner radius
        private var bottomCornerRadius:Number;    // bottom corner radius
        private var fillColors:Array;            // fill colors (two)
        private var setup:Boolean;
        
        // ------------------------------------------------------------------------------------- //
        
        private function setupStyles():void
        {
            fillColors = getStyle("fillColors") as Array;
            if (!fillColors) fillColors = [0xFFFFFF, 0xFFFFFF];
            
            topCornerRadius = getStyle("cornerRadius") as Number;
            if (!topCornerRadius) topCornerRadius = 0;    
            
            bottomCornerRadius = getStyle("bottomCornerRadius") as Number;
            if (!bottomCornerRadius) bottomCornerRadius = topCornerRadius;    
        
        }
        
        // ------------------------------------------------------------------------------------- //
        
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);    
            
            setupStyles();
            
            var g:Graphics = graphics;
            var b:EdgeMetrics = borderMetrics;
            var w:Number = unscaledWidth - b.left - b.right;
            var h:Number = unscaledHeight - b.top - b.bottom;
            var m:Matrix = verticalGradientMatrix(0, 0, w, h);
        
            g.beginGradientFill("linear", fillColors, [1, 1], [0, 255], m);
            
            var tr:Number = Math.max(topCornerRadius-2, 0);
            var br:Number = Math.max(bottomCornerRadius-2, 0);
            
            GraphicsUtil.drawRoundRectComplex(g, b.left, b.top, w, h, tr, tr, br, br);
            g.endFill();
                
        }
        
    }
}