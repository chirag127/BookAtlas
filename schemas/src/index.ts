import { z } from 'zod';

export type ReadingStatus = 'not-started' | 'reading' | 'completed' | 'paused';

export interface BookRequest {
  title: string;
  author: string;
  notes?: string;
}

export const BookRequestSchema = z.object({
  title: z.string().min(1),
  author: z.string().min(1),
  notes: z.string().optional(),
});

export interface Note {
  id: string;
  bookId: string;
  content: string;
  page?: number;
  chapter?: string;
  createdAt: number;
  updatedAt: number;
}

export const NoteSchema = z.object({
  id: z.string(),
  bookId: z.string(),
  content: z.string(),
  page: z.number().optional(),
  chapter: z.string().optional(),
  createdAt: z.number(),
  updatedAt: z.number(),
});

export interface Review {
  id: string;
  bookId: string;
  rating: number;
  title?: string;
  content: string;
  createdAt: number;
  updatedAt: number;
}

export const ReviewSchema = z.object({
  id: z.string(),
  bookId: z.string(),
  rating: z.number().min(1).max(5),
  title: z.string().optional(),
  content: z.string(),
  createdAt: z.number(),
  updatedAt: z.number(),
});

export interface Collection {
  id: string;
  name: string;
  description?: string;
  bookIds: string[];
  createdAt: number;
  updatedAt: number;
}

export const CollectionSchema = z.object({
  id: z.string(),
  name: z.string(),
  description: z.string().optional(),
  bookIds: z.array(z.string()),
  createdAt: z.number(),
  updatedAt: z.number(),
});

export interface ReadingProgress {
  bookId: string;
  status: ReadingStatus;
  currentPage: number;
  totalPages: number;
  startDate?: number;
  finishDate?: number;
  updatedAt: number;
}

export const ReadingProgressSchema = z.object({
  bookId: z.string(),
  status: z.enum(['not-started', 'reading', 'completed', 'paused']),
  currentPage: z.number(),
  totalPages: z.number(),
  startDate: z.number().optional(),
  finishDate: z.number().optional(),
  updatedAt: z.number(),
});

export interface UserSettings {
  readingGoal?: number;
  theme?: 'light' | 'dark' | 'system';
  fontSize?: number;
}

export const UserSettingsSchema = z.object({
  readingGoal: z.number().optional(),
  theme: z.enum(['light', 'dark', 'system']).optional(),
  fontSize: z.number().optional(),
});
