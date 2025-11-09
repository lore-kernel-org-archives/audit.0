Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C04C81
	for <audit@vger.kernel.org>; Sun,  9 Nov 2025 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762715936; cv=none; b=V6AwFE/S21HA6AjRGEBjTBIlaXUfApMgXJGMJGenuSbv2qk8oxc+hH6ssVviUcsz5M9COnz1cXNIh0Ep1Mr+zraQIgqyIQO+oUfUUk/1T65Adv1GaBERtdnYxBHnEtvGvAwMX//4w0fifRDtxE4zdfOoHFpjjFzACahKWQZiOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762715936; c=relaxed/simple;
	bh=Itf/f5QrLhQytTBzAfGHHpBNtQQ/lygYSaNA3kTyhkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKi/pIEa78XGXBd2ncjvOFKaSsYbYIsd/uQei/+HjfPDKLP5WhSb71J1OkUKJPaI4mfmFN++V9wgQafw/qwoPOKuMk5ZvuWs2aJ5ROhS4zWaIcUd9z+4fQxkuo9zpiiqGXCk16MiS49Of3emD4ZgePjqvijgBS2VHVT6BbQ/I5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IdhTc6ql; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IdhTc6ql"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so3608310a12.2
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762715932; x=1763320732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWb68tDfUjwHYNJnlWaoLz9+y6XP8lL7sjGZbkJyjJ8=;
        b=IdhTc6qldD2JBsxww66UvZLcdpIhynhCR8YOiHdcBihhSJ7vxH1MBHPyw1oG9C+blo
         GV2ioJ3MNwiiLZnF815m8Vu3Aq86FFgVVioqtktx3W9pbyhcTT5BjKsX3BiUomTkyfk2
         muEANwGZf2/RBLBZiBNfQtJ1CE2PF4HT4SKOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762715932; x=1763320732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWb68tDfUjwHYNJnlWaoLz9+y6XP8lL7sjGZbkJyjJ8=;
        b=V7KkR4o1GUhUodLipx8idbEcG+vNLXTwz2b8MLNNyHmmypKR2mpb7Fm2H5DSnLwT57
         ftGqQBDc/hXobGVQy7ps620KoCc9Zd2feeZLlr/0uVCId3ccGZp8Z5Wq6TqbImlGd5gt
         cS5Or9jBFQtV8Ldrt+fQ72yZFGTzPzvEH8e2r5NWOA0eyA097gPrxLTJYr/7StlTFjZN
         b51SDJONE1c2MHxXLhI39J8WmxDQXSN4tzlckZ7Nwsbmmc3eoh/nvoJqOjol/bysXakd
         Db05jJBam9aEfzbs2Hv9SNaYogDpzu23u7I1NkeFg6eUEgIH9EqpGhjLCxZ5BCDazBUy
         Bx5A==
X-Forwarded-Encrypted: i=1; AJvYcCVjRGNOk8GXFYVjBtks3+Iv6FlsD6Oct02Q45yQkTO7QtRQ7q6HH67vVPtF5feLVuhcajw9sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcyc3oIvpjZ0QT5NqC/38IzoL4ETf8vfyJeTrv+sVfehMZvzd
	5uHl+dSBgl6+4ei9RTS18CSWjEA1PvQP9e60U3JvH7RytMI46aacEBOcLlAyKRS/jVFRcDiXTuT
	D0sOYUcc=
X-Gm-Gg: ASbGncsMb+6X/HMOAAP9BmCm9RlI15MQRbabyvgI1uNF3ckT99yK8ER7dXSyQ3CpvrA
	vn4JGr1NpDVvwPu9uRZA9l/Efbkx0yCA7x0q2rwwmGb/yCDoNvrCoiYiFQAxmsQFiB35bjGq3ha
	B5I5JJ0KyEb0dEmPbomhRYkqaE32ihqvVmVejgupOOX0krpoiqtib5zl/Mm4PIgGl6+JwFnH+8o
	QZp2VsZyiGSct01yda4igy8wi9560jBPOgjQz6x5+Ehh7qo8xudkhEdjK9wIw19WxSPSJvmr6M/
	gcZgnUhY3Y41hPSZdA3PkWX15havfH32NzXPZpocbSxApCXLN7QHiFHOUB0mon3MHHtz82YPFye
	C9vSmtRiUsrm7GcT8bZSELz8BVFxQTuaZhU0BydcGO945bcCeg0zXMeHC1bYqrrvshLlW4naD7n
	fPNtjxY0o0QfjBOjUaQLh0TpETyE9k0so1fDRPkgY/yKB2Eba9UQ==
X-Google-Smtp-Source: AGHT+IE1aw2JBqW/7STMzkTkuNpcLBLmCrNo6aT+mRJb0T6cPsg46h6cfUvgcDaiT/HXAMJICPwkAQ==
X-Received: by 2002:a05:6402:2106:b0:640:b06f:87c5 with SMTP id 4fb4d7f45d1cf-6415e5cce40mr5300984a12.1.1762715931787;
        Sun, 09 Nov 2025 11:18:51 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64179499189sm2564378a12.8.2025.11.09.11.18.49
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 11:18:49 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b714b1290aeso377120166b.2
        for <audit@vger.kernel.org>; Sun, 09 Nov 2025 11:18:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWksG8F/wSg89INrxhkGGI7eHrG9/TLPY/z/XCwIcdsoVDHi/9R+myGEexgp4ldQMc7vnKzWw==@vger.kernel.org
X-Received: by 2002:a17:907:9608:b0:b6d:5718:d43f with SMTP id
 a640c23a62f3a-b72e05626d4mr526021666b.39.1762715929373; Sun, 09 Nov 2025
 11:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk> <20251109063745.2089578-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20251109063745.2089578-11-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 11:18:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
X-Gm-Features: AWmQ_blhnA0Uuacj1NURQVgqyw-9vJlhsFCpugK5Iunqqr67fsqn4ehAemlhdx8
Message-ID: <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cfb6ed06432e488f"

--000000000000cfb6ed06432e488f
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Nov 2025 at 22:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> These days we have very few places that import filename more than once
> (9 functions total) and it's easy to massage them so we get rid of all
> re-imports.  With that done, we don't need audit_reusename() anymore.
> There's no need to memorize userland pointer either.

Lovely. Ack on the whole series.

I do wonder if we could go one step further, and try to make the
"struct filename" allocation rather much smaller, so that we could fit
it on the stack,m and avoid the whole __getname() call *entirely* for
shorter pathnames.

That __getname() allocation is fairly costly, and 99% of the time we
really don't need it because audit doesn't even get a ref to it so
it's all entirely thread-local.

Right now the allocation is a full page, which is almost entirely for
historical reasons ("__getname()" long long ago used to be
"__get_free_page()"m and then when it was made a kmemc_cache_alloc()
it just stayed page-sized, and we did replaced the size to PATH_MAX
and limited it to 4k regardless of page size - and then with the
embedded 'struct filename' we now have that odd

    #define EMBEDDED_NAME_MAX       (PATH_MAX - offsetof(struct
filename, iname))

and that PATH_MAX thing really is a random value these days, because
the size of the __getname() allocation has *NOTHING* to do with the
maximum pathname, and we actually have to do a *separate* allocation
if we have a long path that needs the whole PATH_MAX.

Now, that separate allocation we do oddly - in that we actually
continue to use that '__getname() allocation for the pathname, and the
new allocation is just for the initial part of 'struct filename'. But
it's *odd* and purely due to those historical oddities. We could make
the new allocation be the actual PATH_MAX size, and continue to use
the smaller original allocation for 'struct filename', and the code in
getname_flags() would be a lot more logical.

Now, for all the same historical reasons there are a few users that
mis-use "__getname()" and "__putname()" to *not* allocate an actual
'struct filename', but really just do a "kmalloc(PATH_MAX)".  The fix
for that is to just leave "__getname()/__putname()" as that odd legacy
"allocate a pathname", and just make the actual real "struct filename"
use proper allocators with proper type checking.

The attached patch is ENTIRELY UNTESTED, so please see it as a
"something like this". But wouldn't it be really nice to not play
those odd games with "struct filename" that getname_flags() currently
plays? And with this, 'struct filename' is small enough that we
*could* just allocate it on the stack if we then also add code to deal
with the audit case (which this does *not* do, just to clarify: this
is literally just the "prep for a smaller structure" part).

Also note that this assumes that short pathname (smaller than that new

   #define EMBEDDED_NAME_MAX      64

size) are actually the common case. With longer paths, and without the
"allocate on stack", this patch will cause two allocations, because it
then does that

                kname = kmalloc(PATH_MAX, GFP_KERNEL);

to allocate the separate name when it didn't fit in the smaller
embedded path buffer. So in this form, this is actually a
pessimization, and again, none of this makes sense *unless* we then go
on to allocate the smaller filename struct on the stack.

Hmm? Comments?

           Linus

--000000000000cfb6ed06432e488f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mhs3jgkf0>
X-Attachment-Id: f_mhs3jgkf0

IGZzL2RjYWNoZS5jICAgICAgICB8ICA4ICsrKystLS0KIGZzL25hbWVpLmMgICAgICAgICB8IDYx
ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
aW5jbHVkZS9saW51eC9mcy5oIHwgMTggKysrKysrKysrKysrKy0tLQogMyBmaWxlcyBjaGFuZ2Vk
LCA0NCBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9kY2Fj
aGUuYyBiL2ZzL2RjYWNoZS5jCmluZGV4IDAzNWNjY2JjOTI3Ni4uOWRlYWEyNmQwZjQ2IDEwMDY0
NAotLS0gYS9mcy9kY2FjaGUuYworKysgYi9mcy9kY2FjaGUuYwpAQCAtMzI0Niw3ICszMjQ2LDcg
QEAgc3RhdGljIHZvaWQgX19pbml0IGRjYWNoZV9pbml0KHZvaWQpCiAJcnVudGltZV9jb25zdF9p
bml0KHB0ciwgZGVudHJ5X2hhc2h0YWJsZSk7CiB9CiAKLS8qIFNMQUIgY2FjaGUgZm9yIF9fZ2V0
bmFtZSgpIGNvbnN1bWVycyAqLworLyogU0xBQiBjYWNoZSBmb3IgYWxsb2NfZmlsZW5hbWUoKSBj
b25zdW1lcnMgKi8KIHN0cnVjdCBrbWVtX2NhY2hlICpuYW1lc19jYWNoZXAgX19yb19hZnRlcl9p
bml0OwogRVhQT1JUX1NZTUJPTChuYW1lc19jYWNoZXApOwogCkBAIC0zMjYzLDggKzMyNjMsMTAg
QEAgdm9pZCBfX2luaXQgdmZzX2NhY2hlc19pbml0X2Vhcmx5KHZvaWQpCiAKIHZvaWQgX19pbml0
IHZmc19jYWNoZXNfaW5pdCh2b2lkKQogewotCW5hbWVzX2NhY2hlcCA9IGttZW1fY2FjaGVfY3Jl
YXRlX3VzZXJjb3B5KCJuYW1lc19jYWNoZSIsIFBBVEhfTUFYLCAwLAotCQkJU0xBQl9IV0NBQ0hF
X0FMSUdOfFNMQUJfUEFOSUMsIDAsIFBBVEhfTUFYLCBOVUxMKTsKKwluYW1lc19jYWNoZXAgPSBr
bWVtX2NhY2hlX2NyZWF0ZV91c2VyY29weSgibmFtZXNfY2FjaGUiLAorCQkJc2l6ZW9mKHN0cnVj
dCBmaWxlbmFtZSksIDAsIFNMQUJfUEFOSUMsCisJCQlvZmZzZXRvZihzdHJ1Y3QgZmlsZW5hbWUs
IGluYW1lKSwgRU1CRURERURfTkFNRV9NQVgsCisJCQlOVUxMKTsKIAogCWRjYWNoZV9pbml0KCk7
CiAJaW5vZGVfaW5pdCgpOwpkaWZmIC0tZ2l0IGEvZnMvbmFtZWkuYyBiL2ZzL25hbWVpLmMKaW5k
ZXggNzM3NzAyMGEyY2JhLi43MzlmNzAzNzJkOTIgMTAwNjQ0Ci0tLSBhL2ZzL25hbWVpLmMKKysr
IGIvZnMvbmFtZWkuYwpAQCAtMTIzLDggKzEyMyw2IEBACiAgKiBQQVRIX01BWCBpbmNsdWRlcyB0
aGUgbnVsIHRlcm1pbmF0b3IgLS1SUi4KICAqLwogCi0jZGVmaW5lIEVNQkVEREVEX05BTUVfTUFY
CShQQVRIX01BWCAtIG9mZnNldG9mKHN0cnVjdCBmaWxlbmFtZSwgaW5hbWUpKQotCiBzdGF0aWMg
aW5saW5lIHZvaWQgaW5pdG5hbWUoc3RydWN0IGZpbGVuYW1lICpuYW1lLCBjb25zdCBjaGFyIF9f
dXNlciAqdXB0cikKIHsKIAluYW1lLT51cHRyID0gdXB0cjsKQEAgLTE0Myw3ICsxNDEsNyBAQCBn
ZXRuYW1lX2ZsYWdzKGNvbnN0IGNoYXIgX191c2VyICpmaWxlbmFtZSwgaW50IGZsYWdzKQogCWlm
IChyZXN1bHQpCiAJCXJldHVybiByZXN1bHQ7CiAKLQlyZXN1bHQgPSBfX2dldG5hbWUoKTsKKwly
ZXN1bHQgPSBhbGxvY19maWxlbmFtZSgpOwogCWlmICh1bmxpa2VseSghcmVzdWx0KSkKIAkJcmV0
dXJuIEVSUl9QVFIoLUVOT01FTSk7CiAKQEAgLTE2MCwxMyArMTU4LDEzIEBAIGdldG5hbWVfZmxh
Z3MoY29uc3QgY2hhciBfX3VzZXIgKmZpbGVuYW1lLCBpbnQgZmxhZ3MpCiAJICovCiAJaWYgKHVu
bGlrZWx5KGxlbiA8PSAwKSkgewogCQlpZiAodW5saWtlbHkobGVuIDwgMCkpIHsKLQkJCV9fcHV0
bmFtZShyZXN1bHQpOworCQkJZnJlZV9maWxlbmFtZShyZXN1bHQpOwogCQkJcmV0dXJuIEVSUl9Q
VFIobGVuKTsKIAkJfQogCiAJCS8qIFRoZSBlbXB0eSBwYXRoIGlzIHNwZWNpYWwuICovCiAJCWlm
ICghKGZsYWdzICYgTE9PS1VQX0VNUFRZKSkgewotCQkJX19wdXRuYW1lKHJlc3VsdCk7CisJCQlm
cmVlX2ZpbGVuYW1lKHJlc3VsdCk7CiAJCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKIAkJfQog
CX0KQEAgLTE3OCwzNSArMTc2LDI2IEBAIGdldG5hbWVfZmxhZ3MoY29uc3QgY2hhciBfX3VzZXIg
KmZpbGVuYW1lLCBpbnQgZmxhZ3MpCiAJICogdXNlcmxhbmQuCiAJICovCiAJaWYgKHVubGlrZWx5
KGxlbiA9PSBFTUJFRERFRF9OQU1FX01BWCkpIHsKLQkJY29uc3Qgc2l6ZV90IHNpemUgPSBvZmZz
ZXRvZihzdHJ1Y3QgZmlsZW5hbWUsIGluYW1lWzFdKTsKLQkJa25hbWUgPSAoY2hhciAqKXJlc3Vs
dDsKLQotCQkvKgotCQkgKiBzaXplIGlzIGNob3NlbiB0aGF0IHdheSB3ZSB0byBndWFyYW50ZWUg
dGhhdAotCQkgKiByZXN1bHQtPmluYW1lWzBdIGlzIHdpdGhpbiB0aGUgc2FtZSBvYmplY3QgYW5k
IHRoYXQKLQkJICoga25hbWUgY2FuJ3QgYmUgZXF1YWwgdG8gcmVzdWx0LT5pbmFtZSwgbm8gbWF0
dGVyIHdoYXQuCi0JCSAqLwotCQlyZXN1bHQgPSBremFsbG9jKHNpemUsIEdGUF9LRVJORUwpOwot
CQlpZiAodW5saWtlbHkoIXJlc3VsdCkpIHsKLQkJCV9fcHV0bmFtZShrbmFtZSk7CisJCWtuYW1l
ID0ga21hbGxvYyhQQVRIX01BWCwgR0ZQX0tFUk5FTCk7CisJCWlmICh1bmxpa2VseSgha25hbWUp
KSB7CisJCQlmcmVlX2ZpbGVuYW1lKHJlc3VsdCk7CiAJCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVN
KTsKIAkJfQotCQlyZXN1bHQtPm5hbWUgPSBrbmFtZTsKLQkJbGVuID0gc3RybmNweV9mcm9tX3Vz
ZXIoa25hbWUsIGZpbGVuYW1lLCBQQVRIX01BWCk7CisJCW1lbWNweShrbmFtZSwgcmVzdWx0LT5p
bmFtZSwgRU1CRURERURfTkFNRV9NQVgpOworCisJCS8vIENvcHkgcmVtYWluaW5nIHBhcnQgb2Yg
dGhlIG5hbWUKKwkJbGVuID0gc3RybmNweV9mcm9tX3VzZXIoa25hbWUgKyBFTUJFRERFRF9OQU1F
X01BWCwKKwkJCWZpbGVuYW1lICsgRU1CRURERURfTkFNRV9NQVgsCisJCQlQQVRIX01BWC1FTUJF
RERFRF9OQU1FX01BWCk7CiAJCWlmICh1bmxpa2VseShsZW4gPCAwKSkgewotCQkJX19wdXRuYW1l
KGtuYW1lKTsKLQkJCWtmcmVlKHJlc3VsdCk7CisJCQlmcmVlX2ZpbGVuYW1lKHJlc3VsdCk7CisJ
CQlrZnJlZShrbmFtZSk7CiAJCQlyZXR1cm4gRVJSX1BUUihsZW4pOwogCQl9Ci0JCS8qIFRoZSBl
bXB0eSBwYXRoIGlzIHNwZWNpYWwuICovCi0JCWlmICh1bmxpa2VseSghbGVuKSAmJiAhKGZsYWdz
ICYgTE9PS1VQX0VNUFRZKSkgewotCQkJX19wdXRuYW1lKGtuYW1lKTsKLQkJCWtmcmVlKHJlc3Vs
dCk7Ci0JCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKLQkJfQotCQlpZiAodW5saWtlbHkobGVu
ID09IFBBVEhfTUFYKSkgewotCQkJX19wdXRuYW1lKGtuYW1lKTsKLQkJCWtmcmVlKHJlc3VsdCk7
CisJCXJlc3VsdC0+bmFtZSA9IGtuYW1lOworCQlpZiAodW5saWtlbHkobGVuID09IFBBVEhfTUFY
LUVNQkVEREVEX05BTUVfTUFYKSkgeworCQkJZnJlZV9maWxlbmFtZShyZXN1bHQpOworCQkJa2Zy
ZWUoa25hbWUpOwogCQkJcmV0dXJuIEVSUl9QVFIoLUVOQU1FVE9PTE9ORyk7CiAJCX0KIAl9CkBA
IC0yNDYsNyArMjM1LDcgQEAgc3RydWN0IGZpbGVuYW1lICpnZXRuYW1lX2tlcm5lbChjb25zdCBj
aGFyICogZmlsZW5hbWUpCiAJc3RydWN0IGZpbGVuYW1lICpyZXN1bHQ7CiAJaW50IGxlbiA9IHN0
cmxlbihmaWxlbmFtZSkgKyAxOwogCi0JcmVzdWx0ID0gX19nZXRuYW1lKCk7CisJcmVzdWx0ID0g
YWxsb2NfZmlsZW5hbWUoKTsKIAlpZiAodW5saWtlbHkoIXJlc3VsdCkpCiAJCXJldHVybiBFUlJf
UFRSKC1FTk9NRU0pOwogCkBAIC0yNTgsMTMgKzI0NywxMyBAQCBzdHJ1Y3QgZmlsZW5hbWUgKmdl
dG5hbWVfa2VybmVsKGNvbnN0IGNoYXIgKiBmaWxlbmFtZSkKIAogCQl0bXAgPSBrbWFsbG9jKHNp
emUsIEdGUF9LRVJORUwpOwogCQlpZiAodW5saWtlbHkoIXRtcCkpIHsKLQkJCV9fcHV0bmFtZShy
ZXN1bHQpOworCQkJZnJlZV9maWxlbmFtZShyZXN1bHQpOwogCQkJcmV0dXJuIEVSUl9QVFIoLUVO
T01FTSk7CiAJCX0KIAkJdG1wLT5uYW1lID0gKGNoYXIgKilyZXN1bHQ7CiAJCXJlc3VsdCA9IHRt
cDsKIAl9IGVsc2UgewotCQlfX3B1dG5hbWUocmVzdWx0KTsKKwkJZnJlZV9maWxlbmFtZShyZXN1
bHQpOwogCQlyZXR1cm4gRVJSX1BUUigtRU5BTUVUT09MT05HKTsKIAl9CiAJbWVtY3B5KChjaGFy
ICopcmVzdWx0LT5uYW1lLCBmaWxlbmFtZSwgbGVuKTsKQEAgLTI5MCwxMSArMjc5LDkgQEAgdm9p
ZCBwdXRuYW1lKHN0cnVjdCBmaWxlbmFtZSAqbmFtZSkKIAkJCXJldHVybjsKIAl9CiAKLQlpZiAo
bmFtZS0+bmFtZSAhPSBuYW1lLT5pbmFtZSkgewotCQlfX3B1dG5hbWUobmFtZS0+bmFtZSk7Ci0J
CWtmcmVlKG5hbWUpOwotCX0gZWxzZQotCQlfX3B1dG5hbWUobmFtZSk7CisJaWYgKG5hbWUtPm5h
bWUgIT0gbmFtZS0+aW5hbWUpCisJCWtmcmVlKG5hbWUtPm5hbWUpOworCWZyZWVfZmlsZW5hbWUo
bmFtZSk7CiB9CiBFWFBPUlRfU1lNQk9MKHB1dG5hbWUpOwogCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgKaW5kZXggYzg5NTE0NmMxNDQ0Li4xOTdh
MjE4OTdhZjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xp
bnV4L2ZzLmgKQEAgLTI4MzMsMTIgKzI4MzMsMTMgQEAgZXh0ZXJuIHN0cnVjdCBrb2JqZWN0ICpm
c19rb2JqOwogCiAvKiBmcy9vcGVuLmMgKi8KIHN0cnVjdCBhdWRpdF9uYW1lczsKKyNkZWZpbmUg
RU1CRURERURfTkFNRV9NQVgJNjQKIHN0cnVjdCBmaWxlbmFtZSB7CiAJY29uc3QgY2hhcgkJKm5h
bWU7CS8qIHBvaW50ZXIgdG8gYWN0dWFsIHN0cmluZyAqLwogCWNvbnN0IF9fdXNlciBjaGFyCSp1
cHRyOwkvKiBvcmlnaW5hbCB1c2VybGFuZCBwb2ludGVyICovCiAJYXRvbWljX3QJCXJlZmNudDsK
IAlzdHJ1Y3QgYXVkaXRfbmFtZXMJKmFuYW1lOwotCWNvbnN0IGNoYXIJCWluYW1lW107CisJY29u
c3QgY2hhcgkJaW5hbWVbRU1CRURERURfTkFNRV9NQVhdOwogfTsKIHN0YXRpY19hc3NlcnQob2Zm
c2V0b2Yoc3RydWN0IGZpbGVuYW1lLCBpbmFtZSkgJSBzaXplb2YobG9uZykgPT0gMCk7CiAKQEAg
LTI5NjAsOCArMjk2MSwxOSBAQCBleHRlcm4gdm9pZCBfX2luaXQgdmZzX2NhY2hlc19pbml0KHZv
aWQpOwogCiBleHRlcm4gc3RydWN0IGttZW1fY2FjaGUgKm5hbWVzX2NhY2hlcDsKIAotI2RlZmlu
ZSBfX2dldG5hbWUoKQkJa21lbV9jYWNoZV9hbGxvYyhuYW1lc19jYWNoZXAsIEdGUF9LRVJORUwp
Ci0jZGVmaW5lIF9fcHV0bmFtZShuYW1lKQkJa21lbV9jYWNoZV9mcmVlKG5hbWVzX2NhY2hlcCwg
KHZvaWQgKikobmFtZSkpCitzdGF0aWMgaW5saW5lIHN0cnVjdCBmaWxlbmFtZSAqYWxsb2NfZmls
ZW5hbWUodm9pZCkKK3sKKwlyZXR1cm4ga21lbV9jYWNoZV9hbGxvYyhuYW1lc19jYWNoZXAsIEdG
UF9LRVJORUwpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgZnJlZV9maWxlbmFtZShzdHJ1Y3Qg
ZmlsZW5hbWUgKm5hbWUpCit7CisJa21lbV9jYWNoZV9mcmVlKG5hbWVzX2NhY2hlcCwgbmFtZSk7
Cit9CisKKy8vIENyYXp5IG9sZCBsZWdhY3kgdXNlcyBmb3IgcGF0aG5hbWUgYWxsb2NhdGlvbnMK
KyNkZWZpbmUgX19nZXRuYW1lKCkga21hbGxvYyhQQVRIX01BWCwgR0ZQX0tFUk5FTCkKKyNkZWZp
bmUgX19wdXRuYW1lKG5hbWUpIGtmcmVlKCh2b2lkICopKG5hbWUpKQogCiBleHRlcm4gc3RydWN0
IHN1cGVyX2Jsb2NrICpibG9ja2Rldl9zdXBlcmJsb2NrOwogc3RhdGljIGlubGluZSBib29sIHNi
X2lzX2Jsa2Rldl9zYihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQo=
--000000000000cfb6ed06432e488f--
