from shapely import centroid

centroids=[]
indexes=[]

for ix, cell in enumerate(cells):
    centroids.append(centroid(cell))
    indexes.append(ix)
    
df = gpd.GeoDataFrame({'index': indexes,'geometry':centroids})
df.plot(column='index')
    
