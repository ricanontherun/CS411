// Program which solves the CSP of coloring a set of countries on a map
// such that no country shares its color with an adjacent country.
#include <iostream>
#include <vector>
#include <utility>

template <typename T>
class GraphNode {
	public:
		using NeighborIterator = typename std::vector<GraphNode<T>>::iterator;
		using NeighborIterators = std::pair<NeighborIterator, NeighborIterator>;

		// Basic constructor
		GraphNode() {}

		// Move constructor
		GraphNode(T && t) {
			this->data = std::move(t);
		}

		// Add a neighbor
		void AddNeighbor(GraphNode<T> node) {
			this->neighbors.push_back(node);
		}

		// Get iterators to the neighbors of this node.
		NeighborIterators GetNeighbors() {
			return std::make_pair<NeighborIterator, NeighborIterator>(
				this->neighbors.begin(),
				this->neighbors.end()
			);
		}

		T & GetData() {
			return this->data;
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
	GraphNode<Country> southern_australia(
		std::move(Country("Southern Australia", "red"))
	);

	GraphNode<Country> western_australia(
		std::move(Country("Western Australia", "yellow"))
	);

	GraphNode<Country> northern(
		std::move(Country("Northern Territory", "orange"))
	);

	GraphNode<Country> queensland(
		std::move(Country("Queensland", "green"))
	);

	southern_australia.AddNeighbor(western_australia);
	southern_australia.AddNeighbor(northern);
	southern_australia.AddNeighbor(queensland);

	auto iterators = southern_australia.GetNeighbors();

	std::cout << "The neighbors of " << southern_australia.GetData().name << " are: \n";
	for ( auto it = iterators.first; it != iterators.second; ++it ) {
		std::cout << "\t" << it->GetData().name << "\n";
	}

	return EXIT_SUCCESS;
}