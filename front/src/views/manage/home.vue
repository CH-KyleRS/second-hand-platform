<template>
  <div>
    <el-row :gutter="10">
      <el-col :span="12">
        <el-card>
          <div id="pie" :style="{width: '100%', height: '400px'}"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <div>
            <h3>求购留言</h3>
          </div>
          <el-collapse accordion v-model="active">
<!--            :name="index"：将索引作为折叠项的名称，用于标识不同的折叠项。-->
            <el-collapse-item :name="index" v-for="(item ,index) in notices" :key="item.id">
              <template slot="title">
                <b>{{ item.title }}</b>
                <span style="margin-left: 50px; color: #888">{{ item.time }}</span>
              </template>
              <div style="padding: 0 20px">{{ item.content }}</div>
            </el-collapse-item>
          </el-collapse>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import API from '../../utils/request'

const url = "/api/user/"

export default {
  name: "Home",
  data() {
    return {
      notices: [],
      active: 0,
      user: {},
    };
  },
  mounted() {//钩子函数在组件被挂载到 DOM 后触发。
    this.user = sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {}
    this.load()
    this.drawLine()
  },
  methods: {
    load() {
      API.get("/api/notice/").then((res) => {
        this.notices = res.data;
      })
    },
    drawLine() {
          const pieOption = {
            title: {text: '分类商品销量统计'},
         /*   tooltip: {trigger: 'item'},
            legend: {top: '30px', left: 'right'},*/
            series: [
              {
                name: '销量',
                type: 'pie',
                radius: ['40%', '70%'],
                itemStyle: {
                  borderRadius: 10,
                  borderColor: '#fff',
                  borderWidth: 2
                },

                data: [


                ]
              }
            ]
          };
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(document.getElementById('pie'))
/*创建了一个 ECharts 实例，并将其存储在变量 myChart 中。这里使用 this.$echarts.init 方法，传入了一个具有 ID 为 'pie' 的 DOM 元素的引用，用于指定饼图的容器。*/
      API.get("/api/goods").then(res => {
        let category = Array.from(new Set(res.data.map(v => v.categoryName)))
       /* 从返回的数据中提取出所有不重复的商品分类名称，并存储在 category 变量中。这里使用了数组的 map 方法(用于对数组中的每个元素进行遍历，并返回一个新的数组)获取每个数据项的 categoryName 属性，
       并使用 Set 数据结构(有序且不重复的集合)和 Array.from 方法(用于将类数组对象或可迭代对象转换为真正的数组)去除重复项。*/
        category.forEach(item => {//遍历每个分类名称
          pieOption.series[0].data.push({name: item, value: res.data.filter(v => v.categoryName === item).map(v => v.sales).reduce((a,b) => a + b)})
        })
        /*将每个分类名称和对应的销量值作为一个对象，添加到 pieOption.series[0].data 数组中。这里使用了 filter 方法过滤出属于当前分类的商品数据项，使用 map 方法获取每个数据项的 sales 属性（销量），并使用 reduce 方法求和得到销量总和。*/
        console.log(pieOption)
        // 在控制台输出配置对象 pieOption，以查看生成的数据项是否正确。
        myChart.setOption(pieOption);/*调用 ECharts 实例的 setOption 方法，将配置对象 pieOption 应用于图表，以绘制出饼图。*/
      })
    }
  },
};
</script>

<style scoped>
</style>
