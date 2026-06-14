import { type ReactNode } from 'react';

interface CalloutProps {
  type: 'info' | 'warning' | 'key' | 'success';
  title?: string;
  children?: ReactNode;
}

const styles: Record<string, string> = {
  info: 'border-blue-500 bg-blue-50 text-blue-900',
  warning: 'border-yellow-500 bg-yellow-50 text-yellow-900',
  key: 'border-purple-500 bg-purple-50 text-purple-900',
  success: 'border-green-500 bg-green-50 text-green-900',
};

const icons: Record<string, string> = {
  info: '\u2139\uFE0F',
  warning: '\u26A0\uFE0F',
  key: '\uD83D\uDD11',
  success: '\u2705',
};

export function Callout({ type, title, children }: CalloutProps) {
  return (
    <div className={`callout border-l-4 p-4 my-4 rounded-r-lg ${styles[type] || styles.info}`}>
      <div className="flex items-start gap-3">
        <span className="text-lg flex-shrink-0">{icons[type] || icons.info}</span>
        <div>
          {title && <strong className="block mb-1">{title}</strong>}
          <div className="text-sm">{children}</div>
        </div>
      </div>
    </div>
  );
}
