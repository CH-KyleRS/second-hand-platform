<template>
  <div>
    <div style="width: 100%; height: 100vh; overflow: hidden" class="bgImg">
      <div style="width: 500px; height: 350px; background-color:rgba(9, 50, 113 ,0.2); border-radius: 10px;
        margin: 50px auto;">

        <div style="width: 260px; margin: 0 auto; padding-top: 30px">
          <div class="item" style="font-size: 20px; color: white">登录</div>
          <div class="item">
            <input type="text" class="inputItem" placeholder="请输入用户名" v-model="user.username">
          </div>

          <div class="item">
            <input type="password" class="inputItem" placeholder="请输入密码" v-model="user.password">
          </div>
          <div class="item" style="text-align: left; display: flex" v-show="count === 3">
            <input type="text" class="inputItem" style="flex: 1;" v-model="code">
            <span @click="refreshCode" style="cursor: pointer; flex: 1;">
              <Identify :identifyCode="identifyCode"></Identify>
             </span>
          </div>
          <div class="item">
            <button class="loginBtn" style="background-color: #00BFFF;" @click="login">登录</button>
          </div>
          <div style="padding: 10px 0; text-align: right">
            <span style="cursor: pointer; color: lightgreen" @click="preReset">忘记密码</span>
            <span style="cursor: pointer; color: lightgreen; margin-left: 10px" @click="goRegister">去注册</span>
          </div>
        </div>
      </div>
    </div>

    <!-- 弹窗   -->
    <el-dialog title="忘记密码" :visible.sync="dialogFormVisible" width="30%"
               :close-on-click-modal="false" >
      <el-form :model="reset">
        <el-form-item label="用户名" label-width="150px">
          <el-input v-model="reset.username" autocomplete="off" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="电话" label-width="150px">
          <el-input v-model="reset.phone" autocomplete="off" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="新密码" label-width="150px">
          <el-input show-password v-model="reset.password" autocomplete="off" style="width: 80%"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">重置</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import API from "@/utils/request";
import {resetRouter} from "@/router";
import Identify from "@/components/common/Identify";


export default {//暴露成员
  name: "Login",
  data() {
    return {
      reset: {},
      dialogFormVisible: false,
      code: '',
      count: 0,
      user: {},
      // 图片验证码
      identifyCode: '',
      // 验证码规则
      identifyCodes: '3456789ABCDEFGHGKMNPQRSTUVWXY',//用这些字符随机生成字符串
    }
  },
  mounted() {
    this.refreshCode()
  },
  components: {Identify},
  methods: {
    goRegister() {
      this.$router.replace("/register")
    },
    preReset() {
      this.dialogFormVisible = true
      this.reset = {}
    },
    save() {
      API.put("/api/user/reset", this.reset).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "重置成功"
          })
          this.dialogFormVisible = false
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
      })
    },
    // 切换验证码
    refreshCode() {
      this.identifyCode = ''
      this.makeCode(this.identifyCodes, 4)
    },
    // 生成随机验证码
    makeCode(o, l) {
      for (let i = 0; i < l; i++) {
        this.identifyCode += this.identifyCodes[Math.floor(Math.random() * (this.identifyCodes.length))]
      }//函数接受两个参数 o 和 l，分别表示生成验证码的目标对象和验证码的长度。函数通过循环从 this.identifyCodes 数组中随机选择字符，将选取的字符追加到 this.identifyCode 中，重复 l 次，以生成指定长度的验证码。
    },
    login() {
      if (!this.user.username) {
        this.$message({
          type: "warning",
          message: "请输入用户名"
        })
        return;
      }
      if (!this.user.password) {
        this.$message({
          type: "warning",
          message: "请输入密码"
        })
        return;
      }
      if (this.count === 3) {
        if (this.code !== this.identifyCode) {
          this.$message({
            type: "error",
            message: "验证码错误"
          })
          return;
        }
      }

      API.post("/api/user/login", this.user).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "登录成功"
          })
          sessionStorage.setItem("user", JSON.stringify(res.data))//将登录成功后获取到的用户信息存储到浏览器的 sessionStorage 中。
          // 重置路由
          resetRouter(JSON.parse(JSON.stringify(res.data.permission)))
  /*        通过将用户信息存储在 sessionStorage 中，可以在会话期间保留用户的登录状态，以便在页面跳转和请求中使用该用户信息。在后续的页面或组件中，
          可以通过读取 sessionStorage.getItem("user") 来获取存储的用户信息，并进行相应的处理。*/
          if (res.data.role.includes(1)) {
            this.$router.replace("/manage/home")
          } else if (res.data.role.includes(2)) {
            this.$router.replace("/front/home")
          }

        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
          this.count++
        }
      })
    }
  }
}
</script>

<style scoped>
.bgImg {
  background: url("../assets/bj.jpg") no-repeat;
  background-size: 100% 100vh;
}

.item {
  text-align: center;
  padding: 10px 0
}

.loginBtn {
  background: forestgreen;
  border-radius: 5px;
  color: white;
  width: 100%;
  padding: 10px;
  cursor: pointer
}

.inputItem {
  width: 100%;
  padding: 10px;
  border-radius: 5px;
}
</style>
