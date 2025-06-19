<template>
  <div>
    <div style="margin-top: 10px">
      <el-carousel height="400px" :interval="3000">
        <el-carousel-item v-for="item in imgList" :key="item.id">
          <a target="_blank" :href="item.url"><img style="width: 100%" :src='item.img' alt=""></a>
        </el-carousel-item>
      </el-carousel>
    </div>

    <!--    其他-->
    <div style="margin-top: 10px">
      <el-card>
        <el-row :gutter="10">
          <!--          具体商品分类情况-->
          <el-col :span="4">
            <div style="border: 1px dashed #ccc; text-align: center; border-bottom: none">
              <div class="category-item" @click="getGoodsByCategory(item.id)" v-for="item in categories" :key="item.id"
                   :class="{ active: (activeIndex === item.id)}">{{item.name }}
              </div>
            </div>
          </el-col>

          <el-col :span="20">
            <!--          分类商品-->
            <div style="min-height: 150px">
              <el-row :gutter="10">
                <el-col :span="6" v-for="item in tableData" :key="item.id">
                  <div style="margin-bottom: 10px; cursor: pointer"  @click="goodsDetail(item.id)">
                    <div style="padding: 5px"><el-image :src="item.imgs[0]" style="width: 100%; height: 100px" fit="contain"></el-image></div>
                    <div style="padding: 5px; height: 20px; text-align: center; font-size: 12px; overflow: hidden">
<!--   @click="goodsDetail(item.id)"，表示当点击商品项时会调用 goodsDetail 方法，传递当前商品项的 ID 作为参数。商品项中包含了图片、商品名称和价格等信息，
使用 <el-image> 组件展示商品图片，<el-tooltip> 组件展示商品名称（在鼠标悬停时显示完整名称），价格以文本形式展示。-->
                      <el-tooltip :content="item.name" placement="bottom" effect="light">
                        <span class="item-title">{{ item.name }}</span>
                      </el-tooltip>
                    </div>
                    <div style="padding: 5px; text-align: center; color: red; font-size: 12px">
                      ￥ {{ item.price }}
                    </div>
                  </div>
                </el-col>
              </el-row>
            </div>

            <!--      无用分页-->
            <div style="margin-top: 20px">
              <el-pagination
                  small
                  @size-change="handleSizeChange"
                  @current-change="handleCurrentChange"
                  :current-page="pageNum"
                  :page-size="pageSize"
                  :page-sizes="[4, 8, 12]"
                  layout=" prev, pager, next"
                  :total="total"
              >
              </el-pagination>
            </div>

          </el-col>
        </el-row>
      </el-card>

    </div>


    <div style="margin-top: 10px">
      <el-row :gutter="10">
        <!--    推荐商品-->
        <el-col :span="18">
          <el-card>
            <div style="padding: 10px 0; border-bottom: 2px solid orangered; font-size: 20px; color: orangered">推荐商品</div>
            <div style="padding: 10px 0">
              <el-row :gutter="10">
                <el-col :span="6" v-for="item in recommend" :key="item.id" style="margin-bottom: 10px">
                  <div style="border: 1px solid #ccc; cursor: pointer; padding: 10px"  @click="goodsDetail(item.id)">
                    <el-image :src="item.imgs[0]" style="width: 100%; height: 100px" fit="contain"></el-image>
                    <div style="padding: 5px; height: 20px; text-align: center; font-size: 12px; overflow: hidden">
                      <el-tooltip :content="item.name" placement="bottom" effect="light">
                        <span class="item-title">{{ item.name }}</span>
                      </el-tooltip>
                    </div>
                    <div style="padding: 5px; text-align: center; color: red; font-size: 12px">
                      ￥ {{ item.price }}
                    </div>
                  </div>

                </el-col>
              </el-row>
            </div>
          </el-card>
        </el-col>

<!--        销售排行-->
        <el-col :span="6">
          <el-card>
            <div style="padding: 10px 0; border-bottom: 2px solid dodgerblue; font-size: 20px; color: dodgerblue">销量排行榜</div>

            <div style="padding: 10px 0">
              <el-row v-for="(item, index) in sales" :key="item.id">
                <div style="padding: 10px 0; cursor: pointer;" @click="goodsDetail(item.id)">
                  <el-col :span="2" style="padding-top: 5px">
                    <span v-if="index === 0" style="color: gold">{{ index + 1 }}</span>
                    <span v-if="index === 1" style="color: silver">{{ index + 1 }}</span>
                    <span v-if="index === 2" style="color: coral">{{ index + 1 }}</span>
                    <span v-if="index > 2">{{ index + 1 }}</span>
                  </el-col>
                  <el-col :span="10"><el-image :src="item.imgs[0]" style="width: 100%; height: 80px" fit="contain"></el-image></el-col>
                  <el-col :span="12">
                    <div style="overflow: hidden; height: 80px; font-size: 12px;padding: 15px">
                      {{ item.name }}
                    </div>
                  </el-col>
                </div>
              </el-row>
            </div>
<!--            //这部分代码是根据 `index` 的值来动态设置排名序号的样式和颜色。根据条件判断，不同的排名会显示不同的颜色。-->
<!--            - `<span v-if="index === 0" style="color: gold">{{ index + 1 }}</span>`：如果 `index` 的值为 0，表示当前是第一名，那么该 `<span>` 元素的文本内容为 `index + 1`，即 1，并且设置文本颜色为金色（gold）。
- `<span v-if="index === 1" style="color: silver">{{ index + 1 }}</span>`：如果 `index` 的值为 1，表示当前是第二名，那么该 `<span>` 元素的文本内容为 `index + 1`，即 2，并且设置文本颜色为银色（silver）。
- `<span v-if="index === 2" style="color: coral">{{ index + 1 }}</span>`：如果 `index` 的值为 2，表示当前是第三名，那么该 `<span>` 元素的文本内容为 `index + 1`，即 3，并且设置文本颜色为珊瑚色（coral）。
- `<span v-if="index > 2">{{ index + 1 }}</span>`：如果 `index` 的值大于 2，表示当前是第四名及以上，那么该 `<span>` 元素的文本内容为 `index + 1`，即实际的排名序号，并不设置特定的文本颜色。

通过上述代码，可以根据排名的不同，使用不同的颜色来标识不同的排名。例如，前三名分别用金色、银色和珊瑚色表示，而第四名及以上则不设置特定颜色，使用默认颜色。-->
          </el-card>
        </el-col>
      </el-row>-

    </div>

  </div>
</template>

<script>
import API from "@/utils/request";

const url = "/api/video/"
const baseUrl = "http://localhost:9999"  // 添加后端基础URL

export default {
  name: "Home",
  data() {
    return {
      sales: [],
      recommend: [],
      tableData: [],
      activeIndex: 0,
      imgList: [],
      user: {},
      categories: [],
      pageNum: 1,
      pageSize: 8,
      total: 0
    };
  },
  created() {//页面中首先被调用
    this.user = sessionStorage.getItem("user") ? JSON.parse(sessionStorage.getItem("user")) : {}
    this.load()
  },
  methods: {
    // 添加处理图片URL的方法
    getImageUrl(path) {
      if (!path) return '';
      if (path.startsWith('http')) return path;
      return `${baseUrl}${path}`;
    },
    goodsDetail(id) {
      this.$router.replace({path: '/front/goods', query: {id: id}})
    },/*goodsDetail 方法用于跳转到商品详情页面，并将商品的 id 作为参数传递给详情页面。
在方法内部，通过 this.$router.replace 方法进行路由跳转。this.$router 是 Vue Router 实例，.replace 方法用于替换当前路由为指定的路由。*/
    getGoodsByCategory(id) {
      this.activeIndex = id
      this.loadTable(id)/*通过调用 loadTable 方法，可以根据选中的商品分类加载对应的商品列表数据。*/
    },
    load() {
      API.get("/api/banner").then(res => {
        this.imgList = res.data.map(item => ({
          ...item,
          img: this.getImageUrl(item.img)
        }));
      })

      API.get("/api/goods/recommend").then(res => {
        this.recommend = res.data

        this.recommend.forEach(item => {
          // 处理下表格的图片显示
          if (!item.imgs) {
            item.imgs = ['']
          } else {
            item.imgs = JSON.parse(item.imgs).map(img => this.getImageUrl(img))
          }
        })
      })

      API.get("/api/goods/sales").then(res => {
        this.sales = res.data

        this.sales.forEach(item => {
          // 处理下表格的图片显示
          if (!item.imgs) {
            item.imgs = ['']
          } else {
            item.imgs = JSON.parse(item.imgs).map(img => this.getImageUrl(img))
          }
        })
      })

      API.get("/api/category").then(res => {
        this.categories = res.data
        this.activeIndex = res.data[0].id
        this.loadTable(res.data[0].id)
      })
    },
    loadTable(categoryId) {
      API.get("/api/goods/byCategory/" + categoryId, {//请求的 URL 是 "/api/goods/byCategory/" + categoryId，其中 categoryId 是动态的分类 ID。
        params: {
          pageNum: this.pageNum,//它们分别表示当前页码和每页显示的商品数量。这些参数将作为请求的查询参数进行传递。
          pageSize: this.pageSize
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total

        this.tableData.forEach(item => {
          // 处理下表格的图片显示
          if (!item.imgs) {
            item.imgs = ['']
          } else {
            item.imgs = JSON.parse(item.imgs)
          }
        })
      })
    },
    handleSizeChange(pageSize) {
      this.pageSize = pageSize;
      this.loadTable(this.categories[0].id)
    },
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum;
      this.loadTable(this.categories[0].id)
    }
  },
};
</script>

<style scoped>
.active {
  color: red !important;
}

.category-item {
  padding: 5px 0;
  border-bottom: 1px dashed #ccc;
  color: #666;
  cursor: pointer;
}

.line1 {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.item-title {
  cursor: pointer;
}
.item-title:hover {
  color: orangered;
}

</style>
