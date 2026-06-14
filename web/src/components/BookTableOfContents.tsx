interface TocSection {
  title: string;
  items: string[];
}

interface BookTableOfContentsProps {
  sections: TocSection[];
}

export function BookTableOfContents({ sections }: BookTableOfContentsProps) {
  return (
    <div className="book-toc my-6 p-4 bg-gray-50 rounded-lg border border-gray-200">
      <h2 className="text-lg font-semibold text-gray-900 mb-4">Table of Contents</h2>
      <nav>
        {sections.map((section, i) => (
          <div key={i} className="mb-3">
            <h3 className="text-sm font-medium text-gray-700">{section.title}</h3>
            <ul className="mt-1 space-y-0.5">
              {section.items.map((item, j) => (
                <li key={j} className="text-sm text-gray-500 ml-4 list-disc list-inside">
                  {item}
                </li>
              ))}
            </ul>
          </div>
        ))}
      </nav>
    </div>
  );
}
