<template>
  <div>
    <div style="padding: 5px 0">
      <el-input v-model="text" @keyup.enter.native="load" style="width: 200px"> <i slot="prefix" class="el-input__icon el-icon-search"></i></el-input>
      <el-button @click="add" type="primary" size="mini" style="margin: 10px">新增</el-button>
    </div>
<!--    包括一个输入框和一个按钮。在输入框输入信息会调用load方法-->
    <el-table :data="tableData" border stripe style="width: 100%">
<!--   tabledata中包含了img信息，所以在scope.row.img直接调用   -->
      <el-table-column prop="id" label="ID" width="100" sortable> </el-table-column>
      <el-table-column label="图片">
        <template slot-scope="scope">
          <el-image style="width: 300px; height: 100px" :src="scope.row.img" :preview-src-list="[scope.row.img]"></el-image>
<!--          当渲染表格时，每一行的图片列会显示对应行的图片-->
        </template>
      </el-table-column>
      <el-table-column prop="url" label="图片描述"></el-table-column>
<!--      创建了一个表格列，根据数据中的 url 属性，在每一行中显示对应的关联URL。prob绑定显示变量-->
      <el-table-column
          fixed="right"
          label="操作"
          width="200">
        <template slot-scope="scope">
          <el-button type="primary" icon="el-icon-edit" circle  @click="edit(scope.row)"></el-button>
          <el-popconfirm
              @confirm="del(scope.row.id)"
              title="确定删除？"
          >
            <el-button type="danger" icon="el-icon-delete" circle slot="reference" style="margin-left: 10px"></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

<!--    在 <el-table-column> 中，使用了插槽（slot-scope="scope"）来自定义单元格内容。在插槽内部，使用了 <el-image> 组件来显示图片。
scope.row.img 绑定了当前行的图片地址，通过 :src 属性进行数据绑定。:preview-src-list="[scope.row.img]" 则指定了图片预览功能的预览源列表，此处只包含当前行的图片地址。-->


    <div style="margin-top: 10px">
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="pageNum"
        :page-size="pageSize"
        :page-sizes="[2, 5, 10]"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      >
      </el-pagination>
    </div>

    <!-- 弹窗   -->
    <el-dialog title="信息" :visible.sync="dialogFormVisible" width="30%"
               :close-on-click-modal="false">
      <el-form :model="entity">
        <el-form-item label="图片" label-width="150px">
          <el-upload action="http://localhost:9999/files/upload" :on-success="fileSuccessUpload" :file-list="fileList">
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="图片描述" label-width="150px">
          <el-input v-model="entity.url" autocomplete="off" style="width: 80%"></el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
// 导入模块和定义URL
import API from '../../utils/request'
const url = "/api/banner/"

export default {
  name: "Banner",
  data() {
    return {
      fileList: [],
      options: [],
      text: '',
      user: {},
      tableData: [],
      pageNum: 1,
      pageSize: 10,
      entity: {},
      total: 0,
      dialogFormVisible: false
    };
  },
  created() {// 在组件创建时，从会话存储中获取用户数据，并通知父组件
    this.user = sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {}
    this.$emit('user', this.user);//可以向外部发出通知，告知其他组件或父组件关于this.user的数据更新或状态改变。
    this.load()
  },
  methods: {
    fileSuccessUpload(res) { // 上传成功后，更新图片路径和文件列表
      this.entity.img = "http://localhost:9999/files/" + res.data;
      this.fileList = [res.data]
      console.log(res)
    },
    handleSizeChange(pageSize) { // 处理每页显示数量变化的事件
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) { // 处理当前页码变化的事件
      this.pageNum = pageNum
      this.load()
    },
    load() { // 加载数据的方法
       API.get(url + "/page", {
          params: {
            pageNum: this.pageNum,
            pageSize: this.pageSize,
            name: this.text
          }
       }).then(res => {
          this.tableData = res.data.records || []
          this.total = res.data.total
       })
    },
    add() { // 打开新增弹窗，并重置实体和文件列表
      this.entity = {}
      this.fileList = []
      this.dialogFormVisible = true
    },
    edit(obj) {// 打开编辑弹窗，并将实体设置为当前行的数据副本，重置文件列表
      this.entity = JSON.parse(JSON.stringify(obj))
      this.fileList = []
      this.dialogFormVisible = true
    },
    save() { // 保存数据的方法
      if (!this.entity.id) {
        API.post(url, this.entity).then(res => {
           if (res.code === '0') { // 新增数据
             this.$message({
               type: "success",
               message: "操作成功"
             })
           } else {
             this.$message({
               type: "error",
               message: res.msg
             })
           }
           this.load()
           this.dialogFormVisible = false
        })
      } else {// 更新数据
        API.put(url, this.entity).then(res => {
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "操作成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.load()
          this.dialogFormVisible = false
        })
      }
    },
    del(id) {// 删除数据的方法
      API.delete(url + id).then(res => {
        this.$message({
          type: "success",
          message: "操作成功"
        })
        this.load()
      })
    }
  },
};

</script>

<style scoped>
</style>
