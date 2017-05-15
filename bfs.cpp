// breadth-first search

#include <iostream>
#include <unordered_map>
#include <vector>
#include <list>

class Graph
{
	public:
		Graph(std::size_t vertices)
			: vertices(vertices)
		{}

		void addEdge(int from, int to)
		{
			this->adjacency_list[from].push_back(to);
		}

		void BFS(int start)
		{
			if ( this->adjacency_list.find(start) == this->adjacency_list.end() ) {
				std::cout << "The graph doesn't contain the vertex " << start << "\n";
				return;
			}

			std::unordered_map<int, bool> visited;

			for ( int i = 0; i < this->adjacency_list.size(); ++i) {
				visited[i] = false;
			}

			std::list<int> queue;

			// Push the starting node on the queue.
			queue.push_back(start);
			visited[start] = true;

			while ( !queue.empty() ) {
				// Remove the queue element
				int node = queue.front();
				std::cout << "Processing node " << node << "\n";
				queue.pop_front();

				// Process the neighbors of this node.
				for ( const auto & neighbor : this->adjacency_list[node] ) {
					if ( !visited[neighbor] ) {
						visited[neighbor] = true;
						queue.push_back(neighbor);
					}
				}
			}
		}
	private:
		std::size_t vertices;
		std::unordered_map<int, std::vector<int>> adjacency_list;
};

int main() {
	Graph graph(1);

	graph.addEdge(1, 2);
	graph.addEdge(1, 10);

	graph.addEdge(10, 20);

	graph.BFS(1);
}
