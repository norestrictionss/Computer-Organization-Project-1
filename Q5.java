class Q5{
    public static int numIslands(char[][] grid) {
        int islandWidth = 0;
        int temp = 0;
        for(int i = 0;i<grid.length;i++){
            for(int j = 0;j<grid[0].length;j++){
                if(grid[i][j] == '1'){
                     temp = maxIsland(grid, i, j, 0);
                     if(temp>islandWidth)
                        islandWidth = temp+1;
                }
                   
            }
        }
        return islandWidth;
        
    }
    
    public static int maxIsland(char[][] grid, int i, int j, int result){
        
        grid[i][j] = '0';
        if(i<grid.length-1 && grid[i+1][j] =='1')
            result = maxIsland(grid, i+1, j, result+1);
        
        if(j<grid[0].length-1 && grid[i][j+1] =='1')
            result= maxIsland(grid, i, j+1, result+1);

        if(j>=1 && grid[i][j-1] =='1')
            result= maxIsland(grid, i, j-1, result+1);
        
        if(i>=1 && grid[i-1][j] =='1')
            result= maxIsland(grid, i-1, j, result+1);
        
        return result;
        
    }

    public static void main(String args[]){
        char grid[][] = new char[][]{
            {'0', '1', '1', '1', '1', '1'},
            {'1', '1', '0', '0', '1', '1'},
            {'0', '1', '0', '0', '1', '1'},
            {'0', '0', '1', '0', '1', '1'},
            {'1', '1', '1', '1', '1', '0'}
        };
        int numIslands = numIslands(grid);
        
         
        System.out.println(numIslands);
    }
}