// Program which solves the CSP of coloring a set of countries on a map
// such that no country shares its color with an adjacent country.
#include <iostream>
#include <vector>

template <typename T>
class GraphNode {
	public:
		// Basic constructor
		GraphNode() {}

		GraphNode(T && t) {
			this->data = std::move(t);
		}

		void AddEdge(GraphNode<T> node) {
			this->neighbors.push_back(node);
		}
	private:
		T data;
		std::vector<GraphNode<T>> neighbors;
};

struct Country {
	std::string name;
	std::string color;

	Country() {}

	Country(std::string name, std::string color)
		: name(name), color(color) {}
};

int main() {
	GraphNode<Country> country_node(std::move(Country("place", "red")));

	return EXIT_SUCCESS;
}