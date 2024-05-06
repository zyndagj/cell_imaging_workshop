from shapely.geometry import Point
xy_x = [x for y in range(256) for x in range(256)]
xy_y = [y for y in range(256) for x in range(256)]

s = gpd.GeoSeries(gpd.points_from_xy(xy_x,xy_y))
instance_map = np.zeros((256,256),dtype=np.uint)

for cell_index, cell in enumerate(cells):
    r = s.sindex.query(cell)
    for ix in r:
        x = int(-s[ix].y)
        y =int(s[ix].x)
        # now check whether point is actually inside the cell 
        # (rather than its bounding box)
        if cell.contains(Point(y,-x)):
            instance_map[x,y]=cell_index
    
fig, ax = plt.subplots()
ax.imshow(instance_map)

plt.show()