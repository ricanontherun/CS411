package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
)

// Primary training example data structure.
type TrainingExample struct {
    example,
    author,
    thread,
    length,
    where,
    action string
}

func ReadTrainingData() ([]TrainingExample) {
    // Open the file
    f, err := os.Open("./training_data")

    if err != nil {
        panic(err)
    }

    defer f.Close() // make sure we close the file.

    examples := make([]TrainingExample, 0)

    reader := bufio.NewReader(f)

    line, err := reader.ReadString('\n')
    index := 0

    for err == nil {
        scanner := bufio.NewScanner(strings.NewReader(line))

        scanner.Split(bufio.ScanWords)

        example := TrainingExample{}

        for scanner.Scan() {
            word := scanner.Text()

            switch index {
                case 0:
                    example.example = word
                case 1:
                    example.author = word
                case 2:
                    example.thread = word
                case 3:
                    example.length = word
                case 4:
                    example.where = word
                case 5:
                    example.action = word
            }

            index++
        }

        examples = append(examples, example)

        index = 0

        line, err = reader.ReadString('\n');
    }

    return examples
}

func SplitDataOnFeature(examples []TrainingExample, feature string) (map[string][]TrainingExample) {
    // Map of values to arrays of examples
    splits := make(map[string][]TrainingExample, 0)

    for i := 0; i < len(examples); i++ {
        example := examples[i]
        value := ""

        // Get the value of the field.
        switch feature {
            case "author":
                value = example.author
            case "thread":
                value = example.thread
            case "length":
                value = example.length
            case "where":
                value = example.where
        }

        splits[value] = append(splits[value], example)
    }

    return splits
}

func DoExamplesAgreeOnTargetFeature(examples []TrainingExample) (bool) {
    num_examples := len(examples)

    if num_examples == 1 {
        return true
    }

    if num_examples == 2 {
        return examples[0].action == examples[1].action
    }

    last_feature_value := examples[0].action

    for i := 1; i < num_examples; i++ {
        if ( last_feature_value != examples[i].action ) {
            return false
        }

        last_feature_value = examples[i].action
    }

    return true;
}

func main() {
    examples := ReadTrainingData()

    fmt.Println(DoExamplesAgreeOnTargetFeature(examples))
}
