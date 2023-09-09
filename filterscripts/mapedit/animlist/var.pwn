enum {
    Text: ANIMLIST_GTD_BG,
    Text: ANIMLIST_GTD_CAPTION,
    Text: ANIMLIST_GTD_CLOSE,
    Text: ANIMLIST_GTD_COLUMN_INDEX,
    Text: ANIMLIST_GTD_COLUMN_LIBRARY,
    Text: ANIMLIST_GTD_COLUMN_NAME,
    Text: ANIMLIST_GTD_PAGE_F,
    Text: ANIMLIST_GTD_PAGE_P,
    Text: ANIMLIST_GTD_PAGE_N,
    Text: ANIMLIST_GTD_PAGE_L,
          MAX_ANIMLIST_GTDS
}

enum {
    PlayerText: ANIMLIST_PTD_SEARCH,
    PlayerText: ANIMLIST_PTD_PAGE,
    PlayerText: ANIMLIST_PTD_ROW_INDEX   [MAX_ANIMLIST_ROWS],
    PlayerText: ANIMLIST_PTD_ROW_LIBRARY [MAX_ANIMLIST_ROWS],
    PlayerText: ANIMLIST_PTD_ROW_NAME    [MAX_ANIMLIST_ROWS],
                MAX_ANIMLIST_PTDS
}

enum {
    ANIMLIST_DATA_PAGE,
    ANIMLIST_DATA_MAXPAGE,
    ANIMLIST_DATA_SEARCH    [MAX_SEARCH_LEN+1 char],
    ANIMLIST_DATA_ROW_INDEX [MAX_ANIMLIST_ROWS],
    ANIMLIST_DATA_COLORED_ROW,
    MAX_ANIMLIST_DATA
}

new
    Text:       g_AnimListGTD [MAX_ANIMLIST_GTDS],
    PlayerText: g_AnimListPTD [MAX_PLAYERS][MAX_ANIMLIST_PTDS],
                g_AnimListData[MAX_PLAYERS][MAX_ANIMLIST_DATA]
 ;
