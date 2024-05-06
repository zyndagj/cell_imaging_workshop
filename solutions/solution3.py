x = np.linspace(0, 12, num=13)
y = np.linspace(0, 16, num=17)
X, Y = np.meshgrid(x, y)

geoms = [Point(p[0], p[1]) for p in np.column_stack((X.reshape(-1), Y.reshape(-1)))]

# add the polygon to the list
geoms.append(Polygon(coords))    

# Create a GeoPandas dataframe with its Geometry column set to contain
# the polygons and points 
types = ['xy']*(len(geoms)-1)
types.append('poly')
df = gpd.GeoDataFrame({'shape_type':types ,'geometry':geoms})
df.plot(column='shape_type')
    
