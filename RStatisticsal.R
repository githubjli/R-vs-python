# 加载必要的库
library(dplyr)
library(ggplot2)

# 1. 加载数据
data <- read.csv("/Users/mac/Rprojecy/R-vs-python/data/gapminder.csv")

# 2. 过滤数据 - 例如，筛选亚洲国家的数据
asia_countries <- filter(data, continent == "Asia")

# 3. 查找数据 - 例如，查找"Belgium"的数据
belgium_data <- filter(data, country == "Belgium")

# 4. 统计 - 计算生命期望、人口和人均GDP的基本统计数据
statistics <- data %>% summarise(AverageLifeExp = mean(lifeExp, na.rm = TRUE), 
                                 TotalPopulation = sum(pop), 
                                 AverageGDP = mean(gdpPercap, na.rm = TRUE))

# 5. 图表 - 创建条形图、折线图等
# 条形图 - 各大洲的平均人均GDP
ggplot(data, aes(x=continent, y=gdpPercap)) + 
  geom_bar(stat="summary", fun="mean") +
  labs(title="Average GDP Per Capita by Continent", x="Continent", y="Average GDP Per Capita")

# 折线图 - 演示用，因为数据集可能只有一个年份
ggplot(data, aes(x=year, y=gdpPercap, group=continent, color=continent)) + 
  geom_line() +
  labs(title="GDP Per Capita Over Time by Continent", x="Year", y="GDP Per Capita")

# 箱线图 - 各大洲的人均GDP
ggplot(data, aes(x=continent, y=gdpPercap)) + 
  geom_boxplot() +
  labs(title="GDP Per Capita by Continent", x="Continent", y="GDP Per Capita")

# 直方图 - 人均GDP的分布
ggplot(data, aes(x=gdpPercap)) + 
  geom_histogram(bins=30) +
  labs(title="Distribution of GDP Per Capita", x="GDP Per Capita", y="Frequency")

# 散点图
ggplot(data, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  labs(title="Life Expectancy vs GDP Per Capita")

# 计算每个大洲的平均寿命，忽略NA值
avg_lifeExp_per_continent <- data %>%
  group_by(continent) %>%
  summarise(AverageLifeExp = mean(lifeExp, na.rm = TRUE))

# 使用饼图风格的条形图来表示
ggplot(avg_lifeExp_per_continent, aes(x="", y=AverageLifeExp, fill=continent)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  labs(title = "Average Life Expectancy by Continent") +
  theme_void()

# 规范化数据
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

avg_data$gdpPercap <- normalize(avg_data$gdpPercap)
avg_data$lifeExp <- normalize(avg_data$lifeExp)

# 添加三个虚拟变量
avg_data$dummy1 <- 0.5
avg_data$dummy2 <- 0.5
avg_data$dummy3 <- 0.5

# 准备雷达图数据
radar_data <- avg_data
radar_data <- rbind(rep(1, ncol(radar_data)), rep(0, ncol(radar_data)), radar_data[-1])

# 绘制雷达图
radarchart(radar_data, axistype = 1,
           pcol=rainbow(ncol(radar_data)-2), pfcol=rainbow(ncol(radar_data)-2, alpha=0.3),
           plty=1, vlcex=0.8)

# 添加图例
legend(x=0.8, y=1, legend = avg_data$continent, bty = "n", pch=20 , col=rainbow(ncol(radar_data)-2))


