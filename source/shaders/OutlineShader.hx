package shaders;

import flixel.FlxG;
import flixel.util.FlxColor;

/**
 * Shader that adds X number of Y color pixels around a sprite
**/
class OutlineShader extends flixel.system.FlxAssets.FlxShader {
    private var enabled = true;
    private var width = 1;
    private var height = 1;

    @:glFragmentSource('
        #pragma header

        // effect enabled
        uniform bool iEnabled;

        // size of pixels along x/y axes
        uniform vec2 iSize;

        // color of the outline
        uniform vec4 iColor;

        void main()
        {
            // the pixel color sample
            vec4 iSample = texture2D(bitmap, openfl_TextureCoordv);

            if (iEnabled) {
                // pixel size of the underlying texture
                vec2 iResolution = openfl_TextureSize;

                // width and height of the outline pencil in relative coords
                float w = iSize.x / iResolution.y;
                float h = iSize.y / iResolution.y;

                // check if left/right/up/down pixel is non-transparent, if so, draw an outline at this location
                if (texture2D(bitmap, vec2(openfl_TextureCoordv.x + w, openfl_TextureCoordv.y)).a != 0.
                    || texture2D(bitmap, vec2(openfl_TextureCoordv.x - w, openfl_TextureCoordv.y)).a != 0.
                    || texture2D(bitmap, vec2(openfl_TextureCoordv.x, openfl_TextureCoordv.y + h)).a != 0.
                    || texture2D(bitmap, vec2(openfl_TextureCoordv.x, openfl_TextureCoordv.y - h)).a != 0.) {
                    iSample = iColor;
                }
            }

            // apply the sampled color to the screen pixel
            gl_FragColor = iSample;
        }
    ')

    public function new(color:FlxColor = 0xff000000, width:Int = 1, height:Int = 1) {
        super();
        this.iColor.value = [color.red, color.green, color.blue, color.alpha];
        this.iSize.value = [width, height];
        this.iEnabled.value = [enabled];
    }

    public function setEnabled(v:Bool) {
        enabled = v;
        this.iEnabled.value = [enabled];
    }

    public function setWidth(v:Int) {
        width = v;
        this.iSize.value = [width, height];
    }

    public function setHeight(v:Int) {
        height = v;
        this.iSize.value = [width, height];
    }

    public function setSize(width:Int, height:Int) {
        this.width = width;
        this.height = height;
        this.iSize.value = [width, height];
    }
}