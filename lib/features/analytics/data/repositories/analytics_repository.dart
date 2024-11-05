abstract class AnalyticsRepository {
  Future<Map<String, dynamic>> getAnalyticsData();
}

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  @override
  Future<Map<String, dynamic>> getAnalyticsData() async {
    // Implementation of api
    return {
      'totalEvents': 25,
      'totalRevenue': 15000,
      'ticketsSold': 450,
      'activeEvents': 8,
      'recentEvents': [
        {
      'image':'https://img.freepik.com/free-vector/abstract-music-festival-poster-template_23-2148233165.jpg?semt=ais_hybrid',
  'name': 'Summer Music Festival',
  'date': '2023-08-15',
  'revenue': 5000,
  'status': 'active' 
        },
        //   {
        //   'image':
        //       'https://img.freepik.com/free-vector/abstract-music-festival-poster-template_23-2148233165.jpg?semt=ais_hybrid',
        //   'name': 'Summer Music Festival',
        //   'date': '2023-08-15',
        //   'revenue': 5000,
        //   'status': 'completed'
        // },
        //   {
        //   'image':
        //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxcwT94gygRHjQz_sLB9R4dpsDq_lLsNqp9g&s',
        //   'name': 'splash paint Festival',
        //   'date': '2023-08-15',
        //   'revenue': '',
        //   'status': 'upcoming'
        // },
        //   {
        //   'image':
        //       'https://media.licdn.com/dms/image/v2/D4D12AQEzjsCb19SnXQ/article-cover_image-shrink_600_2000/article-cover_image-shrink_600_2000/0/1664101744228?e=2147483647&v=beta&t=wQ-yyGaSMk9bDzd_4bLrvDZuDjH9jU4Et_Xw7llUMAY',
        //   'name': 'kuna kuna festival',
        //   'date': '2023-08-15',
        //   'revenue': 5000,
        //   'status': 'canceled'
        // },
      
      ],
    };
  }
}
