Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71222BFC8F
	for <audit@vger.kernel.org>; Tue, 16 Dec 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915746; cv=none; b=k8SGHGiyMTR0kJtvW6G5nK1MaiNUuGfAQ9YwbdGhHfKs+AHiX/vub2qNYwF5sh18SDl3VMXxgwEhdRKBftxrhx6OEE5FPlERBCcEeRZcdb+nDz6yJ/I+hWH0taFqWpEDhywXCnr4SX9fRMjHvCbTTwjLbtAsdmuHsdtTVJznBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915746; c=relaxed/simple;
	bh=kIhSKDmibiZeir6cA6DLCbZr7ql+u1kAXnIHyYbuQVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS9C2vd2/9qR/6aIuwfd1t1TsPkmn4XYZWDwdOhoXJwW9yVJSkUufcz2t67O5ZFvnF5jcptKpU1m7ZaLPAO8rz44yu63UBhZLFs6Y+EnScgDDGHJbeV8CSn+FbzV7g6uPr7uE0r2NgEXiplhcwWnNr/jsCIJQFDkBfiDY37RMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S89KkUna; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S89KkUna"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-594270ec7f9so5522985e87.3
        for <audit@vger.kernel.org>; Tue, 16 Dec 2025 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765915743; x=1766520543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1bbnR9hzdM9Uf+6FrzBwEhl6E+6kDOhpZpgPAvE7Vg=;
        b=S89KkUnaqoFYdw+5He12dGILB4/8WVzBmYaCGuP3wwjIf3verZO3h6yhqkOveTTiFq
         LLRmQCsHkx5+7+2ewLHHcvZUNX3m9EUK/eGK9H6yyjvpD84WNI2z/h29RkkSHnsJVz0u
         ioZaACbEapFKrhQYPw1tHEys82hqDeXLwE9YNcAncM+Rm8J8FHiff+ZE57RdDLMvxuMU
         RO2rS41KObHDdH90x+LX6yqN6t7G5eqpBzEUjzwroaeySr8T3DWT6hEfrO8gpH993xD6
         3yFOhj6uzg/buohO8t7tMPhrXMsJs6fHz0aiogAzJfozYdKGUpOyCjJ2jIe6Dk96HSDR
         hqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915743; x=1766520543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1bbnR9hzdM9Uf+6FrzBwEhl6E+6kDOhpZpgPAvE7Vg=;
        b=XEV0c5FqV8KCaTVxDlt6qhv1dDvfIyct80RxJNA/3LK28Glg31j6tGG7tozQzCTNzx
         Me9kOUrW44r9AMzp0g4d6PlhMK1z7X+o748t4Ypmocw4vzK+92Apq81Jb3DFMukMFYGZ
         62IGhSPLrICKtkUxnGWSbEumRkfqzBJmtsdpRBEaQ5XaqNOa1M5f4/nSsyks3NQyYp6J
         ore1bbilegt2fMnFsnjFV/iq8vIKrE6+ukSZOO+zu+I+XHfmbRT5WKr+e1AakYAB2zyz
         ycLIfN5VwajYCXWOBQ8QhckfKnZ++YgNG5aBfP8t0+0jay1Nae3xVyRM3QX0QcrMCeqV
         vDaw==
X-Gm-Message-State: AOJu0YyT0XZpHJI5AOUEVm0DkyNU8Lyh+KdbjaJd7rhCQpp5dSQyHKU1
	Qp2E79d17eqhY1nNkExc1yyCyKAHfnoJIQ0SgPMMukBM2EXPM/QWnuE9
X-Gm-Gg: AY/fxX5xenkDnQX/2+W01+Z8u0HiWihn9h81gD/vrPK/UEH03DCznPhFm3ROAX9sr+N
	PuNVKiZp6zkuJrbb41WiJmSQTSkWwSU65QDsWltwimGs+SvYZ9oA/8/m6L+zBLrwSo5+3CFgEy4
	/1OSh7vL+zD1B3m5DXG8oya7pOaTuxEZwK3F8Zw/uygCBL6cV4caw42dbb1JrjQ38Kv1PGrzmK2
	OpRbDDQ/iFJovBAnwM1ff+bn7rmyOebuZSEGCqIDkAVfjpS1FstK2P71A6tWod8Iw/0lxuFee3n
	7A/FZuNxe9o/UT6VfPcjeKdLkrTlN7AQb4F7N2SCZd9JZKgLNOpbtM0FCbA2mJAaWjCYT3UICV7
	G4LTBvsOGgxjaiEcJ3z7wScVWD3gPFtvA5GDNiHrgi6Calip6+V9EhLQuWzD09ImwwKBihCeofr
	VjnL42VaYH
X-Google-Smtp-Source: AGHT+IFV1QMqnFEYIhxE0eg69fEl9/ql3eoaZPZV7PrMeB7/xLG89YWVuYGgHgekTUU1ROL/2OouVw==
X-Received: by 2002:a05:6512:3ba2:b0:598:edd4:d68 with SMTP id 2adb3069b0e04-598faa5a3bamr4551753e87.28.1765915742645;
        Tue, 16 Dec 2025 12:09:02 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-599115eb95fsm825534e87.19.2025.12.16.12.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 12:09:02 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: audit@vger.kernel.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	io-uring@vger.kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mjguzik@gmail.com,
	paul@paul-moore.com,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH v3 27/59] do_sys_openat2(): get rid of useless check, switch to CLASS(filename)
Date: Tue, 16 Dec 2025 23:08:58 +0300
Message-ID: <20251216200858.2255839-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216035518.4037331-28-viro@zeniv.linux.org.uk>
References: <20251216035518.4037331-28-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Al Viro <viro@zeniv.linux.org.uk>:
> do_file_open() will do the right thing is given ERR_PTR() for name...

Maybe you meant "right thing if given"?

-- 
Askar Safin
