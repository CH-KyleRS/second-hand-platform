<template>
  <div class="s-canvas">
    <canvas id="s-canvas" :width="contentWidth" :height="contentHeight"></canvas>
  </div>
</template>
<script>
export default {
  name: 'Identify',
  props: {//定义了组件的属性，包括验证码字符串、字体大小范围、背景色范围等等
    identifyCode: {
      type: String,
      default: '1234'
    },
    //identifyCode 是属性的名称。type: String 表示属性的类型为字符串。default: '1234' 表示如果外部没有传入该属性的值，则默认为字符串 '1234'
    fontSizeMin: {
      type: Number,
      default: 28
    },
    fontSizeMax: {
      type: Number,
      default: 40
    },
    backgroundColorMin: {
      type: Number,
      default: 180
    },
    backgroundColorMax: {
      type: Number,
      default: 240
    },
    colorMin: {
      type: Number,
      default: 50
    },
    colorMax: {
      type: Number,
      default: 160
    },
    lineColorMin: {
      type: Number,
      default: 40
    },
    lineColorMax: {
      type: Number,
      default: 180
    },
    dotColorMin: {
      type: Number,
      default: 0
    },
    dotColorMax: {
      type: Number,
      default: 255
    },
    contentWidth: {
      type: Number,
      default: 112
    },
    contentHeight: {
      type: Number,
      default: 40
    }
  },
  methods: {
    // 生成一个随机数
    randomNum (min, max) {//生成一个指定范围内的随机数。
      return Math.floor(Math.random() * (max - min) + min)
    },
    // 生成一个随机的颜色
    randomColor (min, max) {
      var r = this.randomNum(min, max)
      var g = this.randomNum(min, max)
      var b = this.randomNum(min, max)
      return 'rgb(' + r + ',' + g + ',' + b + ')'
    },
    drawPic () {//绘制验证码图片的主要方法。获取 canvas 元素的上下文对象，设置文本基线，绘制背景、文字、干扰线和干扰点。
      var canvas = document.getElementById('s-canvas')
      var ctx = canvas.getContext('2d')
      ctx.textBaseline = 'bottom'
      // 绘制背景
      ctx.fillStyle = this.randomColor(
          this.backgroundColorMin,
          this.backgroundColorMax
      )
      ctx.fillRect(0, 0, this.contentWidth, this.contentHeight)
      // 绘制文字
      for (let i = 0; i < this.identifyCode.length; i++) {
        this.drawText(ctx, this.identifyCode[i], i)
      }
      this.drawLine(ctx)
      this.drawDot(ctx)
    },
    drawText (ctx, txt, i) {//绘制验证码图片中的文字。设置文字样式、位置和旋转角度，并进行绘制。
      ctx.fillStyle = this.randomColor(this.colorMin, this.colorMax)
      ctx.font =
          this.randomNum(this.fontSizeMin, this.fontSizeMax) + 'px SimHei'
      var x = (i + 1) * (this.contentWidth / (this.identifyCode.length + 1))
      var y = this.randomNum(this.fontSizeMax, this.contentHeight - 5)
      var deg = this.randomNum(-30, 30)
      // 修改坐标原点和旋转角度
      ctx.translate(x, y)
      ctx.rotate(deg * Math.PI / 270)
      ctx.fillText(txt, 0, 0)
      // 恢复坐标原点和旋转角度
      ctx.rotate(-deg * Math.PI / 270)
      ctx.translate(-x, -y)
    },
    drawLine (ctx) {//绘制验证码图片中的干扰线。绘制指定数量的随机颜色干扰线。
      for (let i = 0; i < 2; i++) {
        ctx.strokeStyle = this.randomColor(
            this.lineColorMin,
            this.lineColorMax
        )
        ctx.beginPath()
        ctx.moveTo(
            this.randomNum(0, this.contentWidth),
            this.randomNum(0, this.contentHeight)
        )
        ctx.lineTo(
            this.randomNum(0, this.contentWidth),
            this.randomNum(0, this.contentHeight)
        )
        ctx.stroke()
      }
    },
    drawDot (ctx) {//绘制验证码图片中的干扰点。绘制指定数量的随机颜色干扰点。
      for (let i = 0; i < 20; i++) {
        ctx.fillStyle = this.randomColor(0, 255)
        ctx.beginPath()
        ctx.arc(
            this.randomNum(0, this.contentWidth),
            this.randomNum(0, this.contentHeight),
            1,
            0,
            2 * Math.PI
        )
        ctx.fill()
      }
    }
  },//生成一个验证码图片
  watch: {//监听 identifyCode 属性的变化，当属性值变化时调用 drawPic() 方法重新绘制验证码图片。
    identifyCode () {
      this.drawPic()
    }
  },
  mounted () {
    this.drawPic()
  }//组件挂载后调用 drawPic() 方法绘制验证码图片。
}
</script>
<style scoped>
.s-canvas {
  height: 38px;
}
.s-canvas canvas{
  margin-top: 1px;
  margin-left: 8px;
}
</style>
