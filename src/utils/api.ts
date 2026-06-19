// Utility Functions & Response Helpers

export interface ApiResponse<T = any> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
  timestamp: number;
}

/**
 * Success response builder
 */
export function successResponse<T>(
  data: T,
  message?: string
): ApiResponse<T> {
  return {
    success: true,
    data,
    message,
    timestamp: Date.now(),
  };
}

/**
 * Error response builder
 */
export function errorResponse(
  error: string,
  message?: string
): ApiResponse {
  return {
    success: false,
    error,
    message: message || error,
    timestamp: Date.now(),
  };
}

/**
 * Validate request body
 */
export function validateRequestBody<T>(body: any, schema: string[]): T | null {
  if (!body) return null;

  for (const field of schema) {
    if (!(field in body)) {
      return null;
    }
  }

  return body;
}

/**
 * Generate JWT-like token (simple implementation)
 */
export function generateToken(userId: string, expiresIn: number = 86400000): string {
  const payload = {
    userId,
    iat: Date.now(),
    exp: Date.now() + expiresIn,
  };

  // Simple base64 encoding (not cryptographically secure)
  return Buffer.from(JSON.stringify(payload)).toString('base64');
}

/**
 * Verify token
 */
export function verifyToken(token: string): { userId: string } | null {
  try {
    const payload = JSON.parse(Buffer.from(token, 'base64').toString());

    if (payload.exp < Date.now()) {
      return null; // Token expired
    }

    return { userId: payload.userId };
  } catch (e) {
    return null;
  }
}

/**
 * Hash password (simple implementation)
 */
export function hashPassword(password: string): string {
  // Use bcrypt in production
  return Buffer.from(password).toString('base64');
}

/**
 * Compare passwords
 */
export function comparePassword(password: string, hash: string): boolean {
  return hashPassword(password) === hash;
}

/**
 * Validate email
 */
export function isValidEmail(email: string): boolean {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

/**
 * Sanitize input
 */
export function sanitizeInput(input: string, maxLength: number = 500): string {
  return input
    .substring(0, maxLength)
    .replace(/[<>]/g, '') // Remove HTML tags
    .trim();
}

/**
 * Rate limit checker
 */
export class RateLimiter {
  private requests: Map<string, number[]> = new Map();
  private maxRequests: number;
  private windowMs: number;

  constructor(maxRequests: number = 100, windowMs: number = 60000) {
    this.maxRequests = maxRequests;
    this.windowMs = windowMs;
  }

  isAllowed(identifier: string): boolean {
    const now = Date.now();
    const requests = this.requests.get(identifier) || [];

    // Remove old requests outside window
    const recentRequests = requests.filter(t => now - t < this.windowMs);

    if (recentRequests.length >= this.maxRequests) {
      return false;
    }

    recentRequests.push(now);
    this.requests.set(identifier, recentRequests);

    return true;
  }
}

export const apiRateLimiter = new RateLimiter(100, 60000);
