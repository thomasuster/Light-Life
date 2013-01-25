package game
{
    import com.junkbyte.console.Cc;

    import flash.display.DisplayObjectContainer;

    public class CcConfig
    {
        public static function config(flashContainer:DisplayObjectContainer, debugDraw:Function):void
        {
            Cc.config.style.backgroundColor = 0x000000;
            Cc.config.commandLineAllowed = true;
            Cc.config.tracing = true;
            Cc.config.maxLines = 2000;
            Cc.config.rememberFilterSettings = true;
            Cc.startOnStage(flashContainer, "`");
            Cc.addMenu("Debug Draw", debugDraw);
            Cc.width = LightLife.WIDTH;
            Cc.height = 1 / (1.61 * 2) * LightLife.HEIGHT;
        }
    }
}
